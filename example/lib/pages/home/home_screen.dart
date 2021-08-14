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
      actions: [
        PopupMenuButton<int>(
          onSelected: (item) => onLogout(item),
          itemBuilder: (_) => [
            PopupMenuItem(
                enabled: true,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.logout, color: Colors.black),
                    Text(' Logout', style: regularTextStyle(color: Colors.black)),
                  ],
                ),
                value: 0)
          ],
        )
      ],
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
              builder: (_, counter, __) =>
                  Text('$counter', style: regularTextStyle()),
            ),
            SizedBox(height: 20),
            Text('Provider Consumer', style: regularTextStyle()),
            Consumer<HomeViewModel>(
                builder: (_, provider, __) => Text('${provider.state.counter}',
                    style: regularTextStyle())),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return Colors.blue;
                  },
                ),
              ),
              onPressed: () {
                viewModel.callGetApi();
              },
              child: Container(
                height: 44.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Call Get Api', style: regularTextStyle(height: 1.0))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: handleClickCounter,
      tooltip: "Increase",
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

  onLogout(int item) {
    viewModel.logout();
  }
}
