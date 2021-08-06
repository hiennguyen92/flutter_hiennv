import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_stateful.dart';
import 'package:flutter_hiennv/constants/app_textstyles.dart';
import 'package:flutter_hiennv_example/pages/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseStateful<HomeScreen, HomeViewModel> {
  @override
  Widget buildPageWidget(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: buildPageBody(context),
        floatingActionButton: buildFloatingActionButton(context));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text('Home Screen', style: mediumTextStyle()),
    );
  }

  Widget buildPageBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.4),
          border: Border.all(color: Colors.blue, width: 2)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Provider Selector', style: regularTextStyle()),
            Selector<HomeViewModel, int>(
              selector: (_, provider) => provider.state.counter,
              builder: (_, counter, __) => Text('$counter', style: regularTextStyle()),
            ),
            SizedBox(height: 20),
            Text('Provider Consumer', style: regularTextStyle()),
            Consumer<HomeViewModel>(builder: (_, provider, __) => Text('${provider.state.counter}', style: regularTextStyle()))
          ],
        ),
      ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: handleClickCounter,
      tooltip: "Capture",
      backgroundColor: Colors.white,
      child: Icon(
        Icons.add,
        color: Colors.blue,
      ),
    );
  }

  void handleClickCounter() {
    viewModel.increase();
  }
}
