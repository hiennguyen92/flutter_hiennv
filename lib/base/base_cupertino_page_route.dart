import 'package:flutter/cupertino.dart';

class BaseCupertinoPageRoute extends CupertinoPageRoute<Object> {
  Duration? appTransitionDuration;

  RouteSettings? appSettings;

  BaseCupertinoPageRoute(
      {required WidgetBuilder builder,
      this.appSettings,
      this.appTransitionDuration})
      : super(builder: builder);
  
  @override
  Duration get transitionDuration =>
      appTransitionDuration ?? super.transitionDuration;

  @override
  RouteSettings get settings => appSettings ?? super.settings;

}
