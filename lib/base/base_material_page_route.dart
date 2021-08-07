import 'package:flutter/material.dart';

class BaseMaterialPageRoute extends MaterialPageRoute<Object> {
  Duration? appTransitionDuration;

  RouteSettings? appSettings;

  BaseMaterialPageRoute(
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
