import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv_example/models/error.dart';
import 'package:flutter_hiennv_example/models/user.dart';

class AuthResponse extends BaseResponse<Token, Error> {
  AuthResponse(Map<String, dynamic> json) : super(json);

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(json);
  }



  @override
  String toString() {
    print(super.toString());
    return 'UserResponse{ data: $data, error: $error }';
  }

  @override
  Token? convertData(dataJson, raw) {
    if (raw != null) {
      return Token.fromData(raw['accessToken'], null, raw['user']);
    } else {
      return null;
    }
  }

  @override
  Error? convertError(dataError, raw) {
    if(dataError != null){
      Error error = Error(dataError['code'], dataError['message'], raw: raw);
      return error;
    }
    return null;
  }
}
