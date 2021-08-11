import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_model.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/models/token.dart';
import 'package:flutter_hiennv/utils/extension.dart';
import 'package:flutter_hiennv/services/auth/authentication_api.dart';
import 'package:flutter_hiennv/services/auth/authentication_service.dart';

abstract class AuthViewModel<T extends BaseViewState> extends BaseViewModel<T> {

  late AuthenticationService _authenticationService = context.authenticationService();

  AuthenticationService get authenticationService => _authenticationService;

  AuthViewModel(BuildContext context, T state)
      : super(context, state);

}
