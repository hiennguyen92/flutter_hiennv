import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/services/auth/authentication_api_service.dart';
import 'package:flutter_hiennv/services/auth/authentication_service.dart';
import 'package:flutter_hiennv/services/cache/auth_info.dart';
import 'package:flutter_hiennv/services/cache/cache_service.dart';
import 'package:flutter_hiennv/services/network/network_config.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv/services/ui/app_dialog_service.dart';
import 'package:flutter_hiennv/services/ui/app_navigation_service.dart';
import 'package:flutter_hiennv/base/base_app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class BaseApplication<T extends BaseAppRoute> extends StatelessWidget {

  late final T appRoute;
  late final AppNavigationService navigationService;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      AuthInfo authInfo = Provider.of<AuthInfo>(context, listen: false);
      final bool isHasAuthInfo = await authInfo.load();
      if (isHasAuthInfo) {
        afterOpenAppHasAuthInfo(context, authInfo);
      }
    });
    appRoute = Provider.of<T>(context, listen: false);
    navigationService =
        Provider.of<AppNavigationService>(context, listen: false);
    return ScreenUtilInit(
        designSize: designSize,
        builder: () {
          return getApp(context, appRoute, navigationService);
        });
  }

  @protected
  Size get designSize => Size(375, 812);

  @protected
  void afterOpenAppHasAuthInfo(BuildContext context, AuthInfo authInfo);

  @protected
  Widget getApp(
      BuildContext context, T appRoute, AppNavigationService navigationService);

  @protected
  T providerAppRoute();

  @protected
  AuthenticationApiService providerAuthenticationApiService(NetworkService networkService, AuthInfo authInfo);

  List<SingleChildWidget> getBaseProviders() {
    return <SingleChildWidget>[
      Provider<T>(create: (_) => providerAppRoute()),
      Provider<AppNavigationService>(
          create: (_) => AppNavigationService.instance),
      Provider<AppDialogService>(create: (_) => AppDialogService()),
      Provider<CacheService>(create: (_) => CacheService()),
      Provider<NetworkService>(create: (_) => NetworkService(NetworkConfig())),
      ChangeNotifierProvider<AuthInfo>(
          create: (BuildContext context) => AuthInfo(
                Provider.of(context, listen: false),
              )),
      ChangeNotifierProvider<AuthenticationApiService>(
          create: (BuildContext context) => providerAuthenticationApiService(
            Provider.of(context, listen: false),
            Provider.of(context, listen: false),
          )),
      ChangeNotifierProvider<AuthenticationService>(
          create: (BuildContext context) => AuthenticationService(
                Provider.of(context, listen: false),
                Provider.of(context, listen: false),
              )),

    ];
  }
}
