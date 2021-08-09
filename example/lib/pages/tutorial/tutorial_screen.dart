import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hiennv_example/services/navigation_service.dart';
import 'package:provider/provider.dart';

import '../../app_route.dart';

class TutorialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TutorialScreenState();
  }
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        Provider.of<NavigationService>(context, listen: false)
            .pushNamedAndRemoveUntil(AppRoute.loginScreen);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Icon(Icons.image, color: Colors.blue),
    );
  }
}
