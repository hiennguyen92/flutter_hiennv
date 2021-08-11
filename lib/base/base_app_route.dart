import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class BaseAppRoute {

  Widget createProviderByPage<P extends ChangeNotifier>(
    P Function(BuildContext context) provider,
    Widget child,
  ) {
    return ChangeNotifierProvider<P>(
      create: provider,
      builder: (_, __) {
        return child;
      },
    );
  }

  @protected
  Route<Object>? generateRoute(RouteSettings settings);
}
