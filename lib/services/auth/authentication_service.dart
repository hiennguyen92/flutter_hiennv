import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv/services/auth/authentication_api_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';

class AuthenticationService extends BaseChangeNotifier {
  AuthenticationApiService _authenticationApiService;
  AuthInfo _authInfo;

  AuthenticationApiService get authenticationApiService =>
      _authenticationApiService;
  AuthInfo get authInfo => _authInfo;

  AuthenticationService(this._authenticationApiService, this._authInfo);

  Future<void> login(
      String email, String password, ApiCallback? apiCallback) async {
    Token? token =
        await authenticationApiService.login(email, password, apiCallback);
    authInfo.save(token);
  }

  Future<void> loginWithCustom(
      Map<String, dynamic> data, ApiCallback? apiCallback) async {
    Token? token =
        await authenticationApiService.loginWithCustom(data, apiCallback);
    authInfo.save(token);
  }

  Future<void> loginWithSocial(
      String accessToken, String provider, ApiCallback? apiCallback) async {
    Token? token = await authenticationApiService.loginWithSocial(
        accessToken, provider, apiCallback);
    authInfo.save(token);
  }

  Future<void> register(
      Map<String, dynamic> info, ApiCallback? apiCallback) async {
    Token? token = await authenticationApiService.register(info, apiCallback);
    authInfo.save(token);
  }

}
