import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/models/base_response.dart';
import 'package:flutter_hiennv/services/auth/authentication_api.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';



abstract class AuthenticationService<T extends BaseResponse> extends BaseChangeNotifier with AuthenticationApi<T> {

  NetworkService _networkService;
  AuthInfo _authInfo;

  NetworkService get networkService => _networkService;
  AuthInfo get authInfo => _authInfo;

  AuthenticationService(this._networkService, this._authInfo);


}