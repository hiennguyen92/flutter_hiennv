import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_model.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/models/user_response.dart';

class LoginViewModel extends BaseViewModel<LoginViewState> with ApiCallback {
  late NetworkService _networkService;

  LoginViewModel(BuildContext context, NetworkService networkService)
      : _networkService = networkService,
        super(context, LoginViewState());


  Future<void> callLoginApi(String username, String password) async {
    Map<String, dynamic> json = await _networkService.post('login',
        data: <String, dynamic>{
          'username': username,
          'password': password
        },
        baseUrl: 'https://dry0j.mocklab.io',
        apiCallback: this);
    UserResponse usersResponse = UserResponse.fromJson(json);
    print('userResponse: ${usersResponse.hasError()}');
  }

  @override
  Future<void> onCompleted(String path, dynamic response) async {
    this.isLoading = false;
  }

  @override
  Future<void> onStart(String path) async {
    this.isLoading = true;
  }


}

class LoginViewState extends BaseViewState {
  int counter = 0;
}
