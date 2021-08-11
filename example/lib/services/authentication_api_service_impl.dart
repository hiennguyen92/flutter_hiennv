import 'dart:convert';

import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv/services/auth/authentication_api_service.dart';
import 'package:flutter_hiennv/services/auth/authentication_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';

class AuthenticationApiServiceImplement extends AuthenticationApiService {
  AuthenticationApiServiceImplement(
      NetworkService networkService, AuthInfo authInfo)
      : super(networkService, authInfo);

  @override
  Future<Token> login(
      String username, String password, ApiCallback? apiCallback) async {
    Map<String, dynamic> json = await networkService.post('login',
        data: <String, dynamic>{'username': username, 'password': password},
        baseUrl: 'https://dry0j.mocklab.io',
        apiCallback: apiCallback);
    print('login: $json');
    //TODO: Custom json token
    var data = json['raw'];
    print('login: token: ${jsonDecode(data)}');
    Map<String, dynamic> jsonToken = {};
    jsonToken['accessToken'] = data['token'] as String;
    jsonToken['refreshToken'] = '';
    jsonToken['extra'] = data['user'];

    return Token.fromJson(jsonToken);
  }

  @override
  Future<Token> loginWithCustom(
      Map<String, dynamic> data, ApiCallback? apiCallback) {
    // TODO: implement loginWithCustom
    throw UnimplementedError();
  }

  @override
  Future<Token> loginWithSocial(
      String token, String provider, ApiCallback? apiCallback) {
    // TODO: implement loginWithSocial
    throw UnimplementedError();
  }

  @override
  Future<Token> register(
      Map<String, dynamic> info, ApiCallback? apiCallback) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
