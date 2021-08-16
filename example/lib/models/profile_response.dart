import 'package:flutter_hiennv/constants/app_logger.dart';
import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv_example/models/error.dart';
import 'package:flutter_hiennv_example/models/profile.dart';

class ProfileResponse extends BaseResponse<Profile, Error> {
  ProfileResponse(Map<String, dynamic>? json) : super(json);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(json);
  }

  @override
  Profile? convertData(dataJson, raw) {
    if (dataJson != null) {
      return Profile.fromJson(dataJson);
    } else {
      // TODO: custom response
      if (raw != null && raw is Map<String, dynamic>) {
        return Profile.fromJson(raw);
      }
      return null;
    }
  }

  @override
  Error? convertError(dataError, raw) {
    print('convertError: $dataError');
    if (dataError != null) {
      Error error = Error(dataError['code'], dataError['message'], raw: raw);
      return error;
    }
    return null;
  }
}
