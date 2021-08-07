import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'base/base_application.dart';

class AppMultiProvider<T extends BaseApplication> extends MultiProvider {
  final T _application;
  final List<SingleChildWidget> _appProviders;

  AppMultiProvider({required application, required appProviders})
      : _application = application,
        _appProviders = appProviders,
        super(
            providers: [...application.getBaseProviders(), ...appProviders],
            child: application);
}
