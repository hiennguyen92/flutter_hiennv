import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hiennv/constants/app_logger.dart';
import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv/services/network/network_config.dart';

mixin ApiCallback<T> {
  Future<void> onStart(String path);
  Future<void> onApiError(dynamic error);
  Future<void> onCompleted(String path, bool status);
}

class NetworkService {
  final NetworkConfig _networkConfig;

  Dio? _dio;
  AndroidDeviceInfo? _androidInfo;
  IosDeviceInfo? _iosInfo;

  NetworkService(this._networkConfig) {
    _initDio(_networkConfig);
  }

  Future<void> _initDio(NetworkConfig networkConfig) async {
    print('_initDio: $networkConfig');
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      _androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      _iosInfo = await deviceInfo.iosInfo;
    }
    _dio = Dio(BaseOptions(
        contentType: networkConfig.contentType,
        receiveTimeout: networkConfig.receiveTimeout,
        connectTimeout: networkConfig.connectTimeout));

    if (networkConfig.httpProxy != null) {
      (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) {
          return Platform.isAndroid;
        };
        client.findProxy = (uri) {
          return 'PROXY: $uri';
        };
      };
    }
    _dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['source'] =
          Platform.isAndroid ? 'android' : (Platform.isIOS ? 'ios' : '');
      print('options $options');
      handler.next(options);
    }, onResponse: (response, handler) {
      handler.next(response);
    }, onError: (error, handler) {
      handler.next(error);
    }));
    if (networkConfig.isShowHttpLog) {
      print('networkConfig: $networkConfig');
      _dio?.interceptors.add(LogInterceptor(
          responseHeader: true, requestBody: true, responseBody: true));
    }
  }

  Future<BaseResponse> get(String path,
      {String? baseUrl,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress,
      ApiCallback? apiCallback}) async {
    apiCallback?.onStart(path);
    if (_dio == null) {
      await _initDio(_networkConfig);
    }
    if (baseUrl == null || baseUrl.isEmpty) {
      baseUrl = _networkConfig.baseUrl;
    }
    String fullUrl = '$baseUrl/$path';
    print('fullUrl: $fullUrl');
    try {
      Response<dynamic> response = await _dio!.get<Map<String, dynamic>>(
          fullUrl,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      apiCallback?.onCompleted(path, true);
      return BaseResponse(response.data);
    } catch (error) {
      apiCallback?.onCompleted(path, false);
      apiCallback?.onApiError(error);
    }
    return BaseResponse(null);
  }

  Future<BaseResponse> post<T>(String path,
      {String? baseUrl,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress,
      ApiCallback? apiCallback}) async {
    if (_dio == null) {
      await _initDio(_networkConfig);
    }
    if (baseUrl == null || baseUrl.isEmpty) {
      baseUrl = _networkConfig.baseUrl;
    }
    String fullUrl = '$baseUrl/$path';
    print('fullUrl: $fullUrl');
    Response<dynamic> response = await _dio!.post<T>(fullUrl,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    return BaseResponse(response.data);
  }
}
