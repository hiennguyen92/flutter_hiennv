import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv/services/auth/authentication_api_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';

class AuthenticationService extends BaseChangeNotifier {
  AuthenticationApiService _authenticationApiService;
  AuthInfo _authInfo;

  AuthenticationApiService get authenticationApiService =>
      _authenticationApiService;
  AuthInfo get authInfo => _authInfo;

  AuthenticationService(this._authenticationApiService, this._authInfo);

  Future<void> login(
      String email, String password, ApiCallback? apiCallback) async {
    Token token = await authenticationApiService.login(email, password, apiCallback);
    authInfo.save(token);
  }

  Future<void> loginWithCustom(
      Map<String, dynamic> data, ApiCallback? apiCallback) {
    // TODO: implement loginWithCustom
    throw UnimplementedError();
  }

  Future<void> loginWithSocial(
      String token, String provider, ApiCallback? apiCallback) {
    // TODO: implement loginWithSocial
    throw UnimplementedError();
  }

  Future<void> register(
      Map<String, dynamic> info, ApiCallback? apiCallback) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
