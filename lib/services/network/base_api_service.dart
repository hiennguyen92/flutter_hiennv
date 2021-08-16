import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';

abstract class BaseApiService extends BaseChangeNotifier {
  NetworkService _networkService;
  AuthInfo _authInfo;

  NetworkService get networkService => _networkService;
  AuthInfo get authInfo => _authInfo;

  BaseApiService(this._networkService, this._authInfo);

  Future<Options?> buildHeaderOptions(
      {String? contentType = Headers.jsonContentType}) async {
    return Options(headers: buildHeaders(), contentType: contentType);
  }

  Future<Options?> buildAuthHeaderOptions(
      {String? contentType = Headers.jsonContentType}) async {
    final Options? headerOptions =
        await buildHeaderOptions(contentType: contentType);
    headerOptions?.headers?.addAll(buildAuthHeaders());
    return headerOptions;
  }

  @protected
  Map<String, String> buildHeaders() {
    return <String, String>{Headers.acceptHeader: Headers.jsonContentType};
  }

  @protected
  Map<String, String> buildAuthHeaders() {
    if (authInfo.token != null) {
      return <String, String>{
        'Authorization': 'Bearer ${authInfo.token?.accessToken}'
      };
    }
    return {};
  }
}
