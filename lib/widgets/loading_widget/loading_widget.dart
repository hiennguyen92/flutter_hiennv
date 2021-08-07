import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }
}
