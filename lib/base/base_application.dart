import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_app_navigation.dart';
import 'package:flutter_hiennv/base/base_app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class BaseApplication<T extends BaseAppRoute,
    E extends BaseAppNavigation> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final T appRoute = Provider.of<T>(context, listen: false);
    final E navigationService = Provider.of<E>(context, listen: false);
    return ScreenUtilInit(
        designSize: designSize,
        builder: () {
          return getApp(context, appRoute, navigationService);
        });
  }

  @protected
  Size get designSize => Size(375, 812);

  @protected
  Widget getApp(BuildContext context, T appRoute, E navigationService);

  @protected
  T providerAppRoute();

  @protected
  E providerNavigationService();

  List<SingleChildWidget> getBaseProviders() {
    return <SingleChildWidget>[
      Provider<T>(create: (_) => providerAppRoute()),
      Provider<E>(create: (_) => providerNavigationService()),
    ];
  }
}
