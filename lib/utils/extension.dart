import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/services/auth/authentication_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/cache/cache_service.dart';
import 'package:flutter_hiennv/services/ui/app_dialog_service.dart';
import 'package:flutter_hiennv/services/ui/app_navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';

extension ProviderExt on BuildContext {
  NetworkService networkService() {
    return Provider.of<NetworkService>(this, listen: false);
  }

  AppDialogService appDialogService() {
    return Provider.of<AppDialogService>(this, listen: false);
  }

  AppNavigationService appNavigationService() {
    return Provider.of<AppNavigationService>(this, listen: false);
  }

  AuthenticationService authenticationService() {
    return Provider.of<AuthenticationService>(this, listen: false);
  }

  CacheService cacheService() {
    return Provider.of<CacheService>(this, listen: false);
  }

  AuthInfo authInfo() {
    return Provider.of<AuthInfo>(this, listen: false);
  }
}

extension MapJsonExt on Map<String, dynamic> {
  int getInt(String key, {int defaultValue = 0}) {
    return this[key] != null
        ? (int.tryParse(this[key].toString()) ?? defaultValue)
        : defaultValue;
  }

  String getString(String key, {String defaultValue = ''}) {
    return this[key] != null ? this[key].toString() : defaultValue;
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return this[key] != null
        ? (double.tryParse(this[key].toString()) ?? defaultValue)
        : defaultValue;
  }
}
