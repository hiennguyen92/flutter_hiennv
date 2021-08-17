import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hiennv/base/base_stateful.dart';
import 'package:flutter_hiennv/constants/app_textstyles.dart';
import 'package:flutter_hiennv_example/models/profile.dart';
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
                    Icon(Icons.logout, color: Colors.white),
                    Text(' Logout',
                        style: regularTextStyle(color: Colors.white)),
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
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Selector<HomeViewModel, int>(
                        selector: (_, provider) => provider.state.counter,
                        builder: (_, counter, __) => Text('Selector: $counter',
                            style: regularTextStyle()),
                      ),
                      SizedBox(height: 10),
                      Consumer<HomeViewModel>(
                          builder: (_, provider, __) => Text(
                              'Consumer: ${provider.state.counter}',
                              style: regularTextStyle())),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.all(8),
                          textStyle: regularTextStyle(),
                        ),
                        onPressed: () {
                          viewModel.getProfileApiAndSave();
                        },
                        child: Container(
                          height: 44.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Get Profile and Save to DB',
                                  style: regularTextStyle(height: 1.0))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.yellow.withOpacity(0.4),
                              border:
                                  Border.all(color: Colors.yellow, width: 2)),
                          child: Selector<HomeViewModel, Profile?>(
                              selector: (_, provider) => provider.state.profile,
                              builder: (_, profile, __) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      if (profile != null &&
                                          profile.avatarUrl != null)
                                        Image.network(profile.avatarUrl!,
                                            height: 100, width: 100),
                                      if (profile != null &&
                                          profile.name != null)
                                        Text('${profile.name}',
                                            style: boldTextStyle()),
                                      if (profile != null &&
                                          profile.bio != null)
                                        Text('${profile.bio}',
                                            textAlign: TextAlign.center,
                                            style: regularTextStyle()),
                                      if (profile != null &&
                                          profile.url != null)
                                        Text('${profile.url}',
                                            style: regularTextStyle())
                                    ],
                                  ))),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.all(8),
                          textStyle: regularTextStyle(),
                        ),
                        onPressed: () {
                          viewModel.getProfileFromSqlite();
                        },
                        child: Container(
                          height: 44.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Get From Sqlite',
                                  style: regularTextStyle(height: 1.0))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
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
