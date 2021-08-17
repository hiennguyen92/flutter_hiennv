import 'package:dio/dio.dart';
import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';

abstract class AuthenticationApiService extends BaseChangeNotifier {
  NetworkService _networkService;
  AuthInfo _authInfo;

  NetworkService get networkService => _networkService;
  AuthInfo get authInfo => _authInfo;

  AuthenticationApiService(this._networkService, this._authInfo);

  Future<Options> buildHeaderOptions({String? contentType}) async {
    final Map<String, String> header = <String, String>{
      Headers.acceptHeader: Headers.jsonContentType
    };
    return Options(headers: header, contentType: contentType);
  }

  Future<Options> buildAuthHeaderOptions({String? contentType}) async {
    final Options headerOptions =
        await buildHeaderOptions(contentType: contentType);
    if (authInfo.token != null) {
      headerOptions.headers?.addAll(<String, String>{
        'Authorization': 'Bearer ${authInfo.token?.accessToken}'
      });
    }
    return headerOptions;
  }

  Future<Token?> register(Map<String, dynamic> info, ApiCallback? apiCallback);

  Future<Token?> login(String email, String password, ApiCallback? apiCallback);

  Future<Token?> loginWithSocial(
      String token, String provider, ApiCallback? apiCallback);
  Future<Token?> loginWithCustom(
      Map<String, dynamic> data, ApiCallback? apiCallback);
}
