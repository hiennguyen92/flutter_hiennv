
import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';

mixin AuthenticationApi<T extends BaseResponse> {


  Future<T> register(Map<String, dynamic> info, ApiCallback? apiCallback);

  Future<T> login(String email, String password, ApiCallback? apiCallback);
  Future<T> loginWithSocial(String token, String provider, ApiCallback? apiCallback);
  Future<T> loginWithCustom(Map<String, dynamic> data, ApiCallback? apiCallback);


}