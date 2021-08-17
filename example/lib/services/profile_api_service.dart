import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/base_api_service.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/models/profile_response.dart';

class ProfileApiService extends BaseApiService {
  ProfileApiService(NetworkService networkService, AuthInfo authInfo)
      : super(networkService, authInfo);

  @override
  Map<String, String> buildHeaders() {
    super.buildHeaders();
    return {};
  }

  Future<ProfileResponse> getProfile(ApiCallback? apiCallback) async {
    var options = await buildAuthHeaderOptions();
    Map<String, dynamic> json = await networkService.get('profiles/1',
        options: options, apiCallback: apiCallback);
    ProfileResponse profileResponse = ProfileResponse.fromJson(json);
    return profileResponse;
  }
}
