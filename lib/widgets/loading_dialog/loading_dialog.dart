import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({
    Key? key,
    Color? backgroundColor,
    required this.text,
  }) : super(key: key, backgroundColor: backgroundColor);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }

  static showLoadingDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return LoadingDialog(
              text: 'Loading...',
            );
          }),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0x01000000),
      transitionDuration: const Duration(milliseconds: 10),
      transitionBuilder: buildMaterialDialogTransitions,
    );
  }

  static cancelLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static Widget buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
