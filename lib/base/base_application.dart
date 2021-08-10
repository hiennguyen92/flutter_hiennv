import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/services/ui/app_dialog_service.dart';
import 'package:flutter_hiennv/services/ui/app_navigation_service.dart';
import 'package:flutter_hiennv/base/base_app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class BaseApplication<T extends BaseAppRoute> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final T appRoute = Provider.of<T>(context, listen: false);
    final AppNavigationService navigationService =
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
  Widget getApp(
      BuildContext context, T appRoute, AppNavigationService navigationService);

  @protected
  T providerAppRoute();

  List<SingleChildWidget> getBaseProviders() {
    return <SingleChildWidget>[
      Provider<T>(create: (_) => providerAppRoute()),
      Provider<AppNavigationService>(
          create: (_) => AppNavigationService.instance),
      Provider<AppDialogService>(
          create: (_) => AppDialogService()),
    ];
  }
}
