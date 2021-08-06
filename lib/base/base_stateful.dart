import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_view_model.dart';
import 'package:provider/provider.dart';

abstract class BaseStateful<T extends StatefulWidget, E extends BaseViewModel>
    extends State<T> {
  late E viewModel = Provider.of<E>(context, listen: false);

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        afterFirstBuild(context);
      }
    });
  }

  @protected
  void afterFirstBuild(BuildContext context) {}

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: buildPageWidget(context),
    );
  }

  @protected
  Widget buildPageWidget(BuildContext context);


}
