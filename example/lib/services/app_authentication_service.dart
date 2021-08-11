import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv/services/auth/authentication_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/models/user_response.dart';

class AppAuthenticationService extends AuthenticationService<UserResponse> {
  AppAuthenticationService(NetworkService networkService, AuthInfo authInfo)
      : super(networkService, authInfo);

  @override
  Future<UserResponse> login(String email, String password, ApiCallback? apiCallback) async {
          Map<String, dynamic> json = await networkService.post('login',
              data: <String, dynamic>{'username': email, 'password': password},
              baseUrl: 'https://dry0j.mocklab.io',
              apiCallback: apiCallback);
          return UserResponse.fromJson(json);
  }

  @override
  Future<UserResponse> loginWithSocial(String token, String provider, ApiCallback? apiCallback) {
    // TODO: implement loginWith
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> register(Map<String, dynamic> info, ApiCallback? apiCallback) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> loginWithCustom(Map<String, dynamic> data, ApiCallback? apiCallback) {
    throw UnimplementedError();
  }


  // @override
  // Future<UserResponse> login<T BaseResponse>(String email, String password, ApiCallback? apiCallback) async {
  //       Map<String, dynamic> json = await networkService.post('login',
  //           data: <String, dynamic>{'username': email, 'password': password},
  //           baseUrl: 'https://dry0j.mocklab.io',
  //           apiCallback: apiCallback);
  //       return UserResponse.fromJson(json);
  // }





  // @override
  // Future<UserResponse> login(String email, String password, ApiCallback? apiCallback) async {
  //     Map<String, dynamic> json = await networkService.post('login',
  //         data: <String, dynamic>{'username': email, 'password': password},
  //         baseUrl: 'https://dry0j.mocklab.io',
  //         apiCallback: apiCallback);
  //     return UserResponse.fromJson(json);
  // }
  //
  // @override
  // Future<UserResponse> loginWith(String token, String provider, ApiCallback? apiCallback) {
  //   // TODO: implement loginWith
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<UserResponse> register(info, ApiCallback? apiCallback) {
  //   // TODO: implement register
  //   throw UnimplementedError();
  // }





}
