import 'package:flutter_hiennv/models/base_error.dart';
import 'package:flutter_hiennv/models/base_model.dart';
import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv_example/models/error.dart';
import 'package:flutter_hiennv_example/models/user.dart';

class UserResponse extends BaseResponse<User, Map<String, dynamic>> {
  UserResponse(Map<String, dynamic> json) : super(json);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(json);
  }

  @override
  String toString() {
    print(super.toString());
    return 'UserResponse{ data: $data, error: $error }';
  }

  @override
  User? convertData(dataJson, raw) {
    if (dataJson != null) {
      return User.fromJson(dataJson);
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? convertError(dataError, raw) {
    return dataError;
  }
}
