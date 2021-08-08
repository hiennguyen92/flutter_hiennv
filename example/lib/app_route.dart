import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_app_route.dart';
import 'package:flutter_hiennv/base/base_material_page_route.dart';
import 'package:flutter_hiennv/services/network/network_service.dart';
import 'package:flutter_hiennv_example/pages/home/home_screen.dart';
import 'package:flutter_hiennv_example/pages/home/home_view_model.dart';
import 'package:flutter_hiennv_example/pages/tutorial/tutorial_screen.dart';
import 'package:provider/provider.dart';

class AppRoute extends BaseAppRoute {
  static final AppRoute _instance = AppRoute._private();
  factory AppRoute() {
    return _instance;
  }
  AppRoute._private();

  static AppRoute get instance => _instance;

  static const tutorialScreen = '/tutorialScreen';
  static const homeScreen = '/homeScreen';

  @override
  Route<Object>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case tutorialScreen:
        return AppPageRoute(
            appSettings: settings, builder: (_) => TutorialScreen());
      case homeScreen:
        return AppPageRoute(
            appSettings: settings,
            builder: (_) => createProviderByPage(
                ((BuildContext context) => HomeViewModel(context, Provider.of<NetworkService>(context, listen: false))),
                HomeScreen()));
    }
  }
}

class AppPageRoute extends BaseMaterialPageRoute {
  AppPageRoute({required WidgetBuilder builder, RouteSettings? appSettings})
      : super(builder: builder, appSettings: appSettings);
}
