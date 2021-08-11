import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/auth_view_model.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/services/network/api_callback.dart';

class LoginViewModel extends AuthViewModel<LoginViewState> with ApiCallback {


  LoginViewModel(BuildContext context) : super(context, LoginViewState());


  Future<void> callLoginApi(String username, String password) async {
    await authenticationService.login(username, password, this);
  }


  String? usernameValidator(value) {
    state.username = value;
    if(!state.usernameIsValid()){
      return 'Please enter username';
    }
    return null;
  }

  String? passwordValidator(value) {
    state.password = value;
    if(!state.passwordIsValid()){
      return 'Please enter password';
    }
    return null;
  }

  @override
  Future<void> onCompleted(String path, response) async {
    isLoading = false;
  }

  @override
  Future<void> onStart(String path) async {
    isLoading = true;
  }


}

class LoginViewState extends BaseViewState {
  int counter = 0;
  String? username;
  String? password;

  bool usernameIsValid() {
    if (username == null || (username != null && username!.isEmpty)) {
      return false;
    }
    return true;
  }

  bool passwordIsValid() {
    if (password == null || (password != null && password!.isEmpty)) {
      return false;
    }
    return true;
  }

}
