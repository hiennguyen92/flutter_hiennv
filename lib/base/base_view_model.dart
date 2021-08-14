import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_change_notifier.dart';
import 'package:flutter_hiennv/base/base_view_state.dart';
import 'package:flutter_hiennv/services/auth/authentication_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/cache/cache_service.dart';
import 'package:flutter_hiennv/services/ui/app_dialog_service.dart';
import 'package:flutter_hiennv/services/ui/app_navigation_service.dart';
import 'package:flutter_hiennv/utils/extension.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';

abstract class BaseViewModel<T extends BaseViewState> extends BaseChangeNotifier {

  BuildContext context;
  late NetworkService _networkService = context.networkService();
  late AppDialogService _appDialogService = context.appDialogService();
  late AppNavigationService _appNavigationService = context.appNavigationService();
  late AuthenticationService _authenticationService = context.authenticationService();
  late CacheService _cacheService = context.cacheService();
  late AuthInfo _authInfo = context.authInfo();
  bool _isLoading = false;
  T _state;

  bool get isLoading => _isLoading;
  T get state => _state;
  NetworkService get networkService => _networkService;
  AppDialogService get appDialogService => _appDialogService;
  AppNavigationService get appNavigationService => _appNavigationService;
  AuthenticationService get authenticationService => _authenticationService;
  CacheService get cacheService => _cacheService;
  AuthInfo get authInfo => _authInfo;

  set isLoading(bool isLoading) {
    if (_isLoading != isLoading) {
      _isLoading = isLoading;
      this.notifyListeners();
    }
  }

  BaseViewModel(this.context, this._state);

}
