import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_hiennv/base/base_app_route.dart';
import 'package:flutter_hiennv/base/base_application.dart';
import 'package:flutter_hiennv/flutter_hiennv.dart';
import 'package:flutter_hiennv/services/navigation_service.dart';
import 'package:flutter_hiennv_example/AppRoute.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var application = Application();

  runApp(MultiProvider(
      providers: application.getBaseProviders(),
    child: application,
  ));
}

class Application extends BaseApplication<AppRoute> {

  @override
  Widget getApp(BuildContext context, AppRoute appRoute) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: appRoute.generateRoute,
      initialRoute: AppRoute.tutorialScreen,
      navigatorKey: NavigationService.navigationKey,
      navigatorObservers: <NavigatorObserver>[
        NavigationService.routeObserver
      ],
    );
  }

  @override
  AppRoute providerAppRoute() {
    return AppRoute.instance;
  }

}
