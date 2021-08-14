import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/network_config.dart';

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
        baseUrl: networkConfig.baseUrl,
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

  Dio? get instance => _dio;

  String getValidPath(String? baseUrl, String? path) {
    if (path == null || path.isEmpty) return baseUrl ?? '';
    RegExp regExp = new RegExp(
      r"/^((http|https):\/\/)/",
      caseSensitive: false,
      multiLine: false,
    );
    if (regExp.hasMatch(path)) return path;
    if (baseUrl != null) {
      if (baseUrl.endsWith('/') && path.startsWith('/')){
        if (baseUrl.length > 0) {
          baseUrl = baseUrl.substring(0, baseUrl.length - 1);
        }
      }
      return '$baseUrl/$path';
    }
    return '$baseUrl/$path';
  }

  Future<Map<String, dynamic>> get(String path,
      {String? baseUrl,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ApiCallback? apiCallback,
      String? dataKey = 'data',
      String? errorKey = 'error'}) async {
    apiCallback?.onStart(path);
    try {
      if (_dio == null) {
        await _initDio(_networkConfig);
      }
      path = getValidPath(baseUrl, path);
      Response<Map<String, dynamic>> response =
          await _dio!.get<Map<String, dynamic>>(path,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: apiCallback?.onReceiveProgress);

      Map<String, dynamic> responseSuccess = _buildResponseSuccess(
          response.data,
          dataKey: dataKey,
          errorKey: errorKey);
      apiCallback?.onCompleted(path, responseSuccess);
      return responseSuccess;
    } catch (error) {
      Map<String, dynamic> responseError = _buildResponseException(error);
      apiCallback?.onCompleted(path, responseError);
      return responseError;
    }
  }

  Future<Map<String, dynamic>> post(String path,
      {String? baseUrl,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ApiCallback? apiCallback,
      String? dataKey = 'data',
      String? errorKey = 'error'}) async {
    apiCallback?.onStart(path);
    try {
      if (_dio == null) {
        await _initDio(_networkConfig);
      }
      path = getValidPath(baseUrl, path);
      Response<Map<String, dynamic>> response =
          await _dio!.post<Map<String, dynamic>>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: apiCallback?.onSendProgress,
              onReceiveProgress: apiCallback?.onReceiveProgress);
      Map<String, dynamic> responseSuccess = _buildResponseSuccess(
          response.data,
          dataKey: dataKey,
          errorKey: errorKey);
      apiCallback?.onCompleted(path, responseSuccess);
      return responseSuccess;
    } catch (error) {
      Map<String, dynamic> responseError = _buildResponseException(error);
      apiCallback?.onCompleted(path, responseError);
      return responseError;
    }
  }

  Future<Map<String, dynamic>> put(String path,
      {String? baseUrl,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ApiCallback? apiCallback,
      String? dataKey = 'data',
      String? errorKey = 'error'}) async {
    apiCallback?.onStart(path);
    try {
      if (_dio == null) {
        await _initDio(_networkConfig);
      }
      path = getValidPath(baseUrl, path);
      Response<Map<String, dynamic>> response =
          await _dio!.put<Map<String, dynamic>>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: apiCallback?.onSendProgress,
              onReceiveProgress: apiCallback?.onReceiveProgress);
      Map<String, dynamic> responseSuccess = _buildResponseSuccess(
          response.data,
          dataKey: dataKey,
          errorKey: errorKey);
      apiCallback?.onCompleted(path, responseSuccess);
      return responseSuccess;
    } catch (error) {
      Map<String, dynamic> responseError = _buildResponseException(error);
      apiCallback?.onCompleted(path, responseError);
      return responseError;
    }
  }

  Future<Map<String, dynamic>> patch(String path,
      {String? baseUrl,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ApiCallback? apiCallback,
      String? dataKey = 'data',
      String? errorKey = 'error'}) async {
    apiCallback?.onStart(path);
    try {
      if (_dio == null) {
        await _initDio(_networkConfig);
      }
      path = getValidPath(baseUrl, path);
      Response<Map<String, dynamic>> response =
          await _dio!.patch<Map<String, dynamic>>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: apiCallback?.onSendProgress,
              onReceiveProgress: apiCallback?.onReceiveProgress);
      Map<String, dynamic> responseSuccess = _buildResponseSuccess(
          response.data,
          dataKey: dataKey,
          errorKey: errorKey);
      apiCallback?.onCompleted(path, responseSuccess);
      return responseSuccess;
    } catch (error) {
      Map<String, dynamic> responseError = _buildResponseException(error);
      apiCallback?.onCompleted(path, responseError);
      return responseError;
    }
  }

  Future<Map<String, dynamic>> delete(String path,
      {String? baseUrl,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ApiCallback? apiCallback,
      String? dataKey = 'data',
      String? errorKey = 'error'}) async {
    apiCallback?.onStart(path);
    try {
      if (_dio == null) {
        await _initDio(_networkConfig);
      }
      path = getValidPath(baseUrl, path);
      Response<Map<String, dynamic>> response =
          await _dio!.delete<Map<String, dynamic>>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken);
      Map<String, dynamic> responseSuccess = _buildResponseSuccess(
          response.data,
          dataKey: dataKey,
          errorKey: errorKey);
      apiCallback?.onCompleted(path, responseSuccess);
      return responseSuccess;
    } catch (error) {
      Map<String, dynamic> responseError = _buildResponseException(error);
      apiCallback?.onCompleted(path, responseError);
      return responseError;
    }
  }

  Future<Map<String, dynamic>> head(String path,
      {String? baseUrl,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ApiCallback? apiCallback,
      String? dataKey = 'data',
      String? errorKey = 'error'}) async {
    apiCallback?.onStart(path);
    try {
      if (_dio == null) {
        await _initDio(_networkConfig);
      }
      path = getValidPath(baseUrl, path);
      Response<Map<String, dynamic>> response =
          await _dio!.head<Map<String, dynamic>>(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken);
      Map<String, dynamic> responseSuccess = _buildResponseSuccess(
          response.data,
          dataKey: dataKey,
          errorKey: errorKey);
      apiCallback?.onCompleted(path, responseSuccess);
      return responseSuccess;
    } catch (error) {
      Map<String, dynamic> responseError = _buildResponseException(error);
      apiCallback?.onCompleted(path, responseError);
      return responseError;
    }
  }

  Map<String, dynamic> _buildResponseSuccess(json,
      {String? dataKey = 'data', String? errorKey = 'error'}) {
    dynamic rawData, rawError;
    if ((json is Map) && dataKey != null) {
      rawData = json[dataKey];
    } else {
      rawData = null;
    }
    if ((json is Map) && errorKey != null) {
      rawError = json[errorKey];
    } else {
      rawError = null;
    }
    Map<String, dynamic> data = {};
    data['data'] = rawData;
    data['error'] = rawError;
    data['raw'] = json;
    return data;
  }

  Map<String, dynamic> _buildResponseException(error) {
    int errorCode = -1;
    String message = '';
    String raw = '';
    if (error is DioError && error.type == DioErrorType.response) {
      if (error.response != null && error.response!.statusCode != null) {
        errorCode = error.response!.statusCode!;
      }
      if (error.response != null && error.response!.statusMessage != null) {
        message = error.response!.statusMessage!;
      }
      if (message.isEmpty) {
        message = error.message;
      }
      if (error.response != null && error.response!.data != null) {
        raw = error.response!.data;
      }
    } else {
      message = error.toString();
    }
    Map<String, dynamic> data = {};
    data['data'] = null;
    data['error'] = <String, dynamic>{'code': errorCode, 'message': message};
    data['raw'] = raw;
    return data;
  }
}
