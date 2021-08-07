import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_hiennv/base/base_application.dart';
import 'package:flutter_hiennv/app_multiprovider.dart';
import 'package:flutter_hiennv_example/AppRoute.dart';
import 'package:flutter_hiennv_example/services/navigation_service.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppMultiProvider(
      application: Application(), appProviders: <SingleChildWidget>[]));
}

class Application extends BaseApplication<AppRoute, NavigationService> {
  @override
  Widget getApp(BuildContext context, AppRoute appRoute,
      NavigationService navigationService) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: appRoute.generateRoute,
      initialRoute: AppRoute.tutorialScreen,
      navigatorKey: navigationService.navigationKey,
      navigatorObservers: <NavigatorObserver>[navigationService.routeObserver],
    );
  }

  @override
  AppRoute providerAppRoute() {
    return AppRoute.instance;
  }

  @override
  NavigationService providerNavigationService() {
    return NavigationService.instance;
  }
}
