import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hiennv/constants/app_logger.dart';
import 'package:flutter_hiennv/services/auth/authentication_api_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/network/network_config.dart';
import 'package:flutter_hiennv_example/configs/app_env_config.dart';
import 'package:flutter_hiennv_example/services/authentication_api_service_impl.dart';
import 'package:flutter_hiennv_example/services/database_service.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_hiennv/base/base_application.dart';
import 'package:flutter_hiennv/app_multiprovider.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/app_route.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  AppEnvConfig(envType: EnvType.PROD);

  List<SingleChildWidget> appProviders = <SingleChildWidget>[
    Provider<DatabaseService>(create: (_) => DatabaseService())
  ];
  runApp(
      AppMultiProvider(application: Application(), appProviders: appProviders));
}

class Application extends BaseApplication<AppRoute> {
  @override
  State<StatefulWidget> createState() {
    return _ApplicationState();
  }

  @override
  AuthenticationApiService authenticationApiServiceProvider(
      NetworkService networkService, AuthInfo authInfo) {
    return AuthenticationApiServiceImplement(networkService, authInfo);
  }

  @override
  AppRoute appRouteProvider() {
    return AppRoute.instance;
  }

  @override
  NetworkConfig networkConfig() {
    return AppEnvConfig.instance.networkConfig;
  }
}

class _ApplicationState extends BaseApplicationState<Application> {
  @override
  void afterOpenAppHasAuthInfo(BuildContext context, AuthInfo authInfo) {
    logger.i('afterOpenAppHasAuthInfo: $authInfo');
    navigationService.pushNamedAndRemoveUntil(AppRoute.homeScreen);
  }

  @override
  Widget getApp(BuildContext context) {
    AppRoute appRoute = Provider.of<AppRoute>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: appRoute.generateRoute,
      initialRoute: AppRoute.tutorialScreen,
      navigatorKey: navigationService.navigationKey,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      navigatorObservers: <NavigatorObserver>[navigationService.routeObserver],
    );
  }
}
