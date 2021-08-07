

import 'package:flutter_hiennv/base/base_app_navigation.dart';

class NavigationService extends BaseAppNavigation {

  static final NavigationService _instance = NavigationService._private();
  factory NavigationService() {
    return _instance;
  }
  NavigationService._private();

  static NavigationService get instance => _instance;

}