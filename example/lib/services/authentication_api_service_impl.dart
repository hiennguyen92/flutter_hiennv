import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv/services/auth/authentication_api_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/models/auth_response.dart';

class AuthenticationApiServiceImplement extends AuthenticationApiService {
  AuthenticationApiServiceImplement(
      NetworkService networkService, AuthInfo authInfo)
      : super(networkService, authInfo);

  @override
  Future<Token?> login(
      String username, String password, ApiCallback? apiCallback) async {

    Map<String, dynamic> json = await networkService.post('login',
        data: <String, dynamic>{'email': username, 'password': password},
        apiCallback: apiCallback);
    print('login: $json');
    AuthResponse authResponse = AuthResponse.fromJson(json);
    //TODO: Custom json token
    if(authResponse.hasError()){
      return null;
    }else {
      return authResponse.data;
    }
  }

  @override
  Future<Token?> loginWithCustom(
      Map<String, dynamic> data, ApiCallback? apiCallback) {
    // TODO: implement loginWithCustom
    throw UnimplementedError();
  }

  @override
  Future<Token?> loginWithSocial(
      String token, String provider, ApiCallback? apiCallback) {
    // TODO: implement loginWithSocial
    throw UnimplementedError();
  }

  @override
  Future<Token?> register(
      Map<String, dynamic> info, ApiCallback? apiCallback) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
