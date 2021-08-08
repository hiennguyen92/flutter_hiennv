import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv_example/models/user.dart';

class UserResponse extends BaseResponse<User, Map<String, dynamic>> {
  UserResponse(Map<String, dynamic> json) : super(json);

  @override
  User? dataFromJson(data) {
    // TODO: implement dataFromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? errorFromJson(error) {
    // TODO: implement errorFromJson
    throw UnimplementedError();
  }
  


  // @override
  // User? dataFromJson(data) {
  //   if (data != null) {
  //     return User.fromJson(data);
  //   } else {
  //     return null;
  //   }
  // }
  //
  // @override
  // Map<String, dynamic>? errorFromJson(error) {
  //   if (data != null) {
  //     return error as Map<String, dynamic>;
  //   } else {
  //     return null;
  //   }
  // }
}
