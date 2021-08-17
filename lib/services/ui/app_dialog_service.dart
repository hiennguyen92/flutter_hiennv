import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hiennv/constants/app_textstyles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppDialogService {
  BuildContext? _context;

  /// iOS: One time only show been one Dialog
  bool _forceShowDialog = false;

  Future<void> showAlertIOSDialog(
      {required BuildContext context,
      String? title,
      String? content,
      String? textButton}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return showDialogWithBody(
      context,
      CupertinoAlertDialog(
        title: Text(title ?? 'Alert'),
        content: SingleChildScrollView(
          child: SelectableText(content ?? ''),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              hideAppDialog();
            },
            child: Text(textButton ?? 'Ok'),
          ),
        ],
      ),
    );
  }

  Future<void> showAlertAndroidDialog(
      {required BuildContext context,
      String? title,
      String? content,
      String? textButton}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return showDialogWithBody(
      context,
      AlertDialog(
        title: Text(title ?? 'Alert'),
        content: SingleChildScrollView(
          child: SelectableText(content ?? ''),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              hideAppDialog();
            },
            child: Text(textButton ?? 'Ok'),
          ),
        ],
      ),
    );
  }

  Future<void> showDialogWithBody(BuildContext context, Widget body) async {
    hideAppDialog(force: true);
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          _context = context;
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            if (_forceShowDialog) {
              hideAppDialog();
            }
          });
          return body;
        });
  }

  Future<void> showCustomDialog(BuildContext context, Widget body,
      {bool? barrierDismissible,
      Color? barrierColor,
      Duration? transitionDuration,
      RouteTransitionsBuilder? transitionBuilder}) async {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        _context = context;
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          if (_forceShowDialog) {
            hideAppDialog();
          }
        });
        return Material(type: MaterialType.transparency, child: body);
      },
      barrierDismissible: barrierDismissible ?? false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black54,
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 10),
      transitionBuilder: transitionBuilder ?? _buildDialogTransitionsDefault,
    );
  }

  Future<void> showLoading(BuildContext context,
      {Color? colorBackground,
      double? sizeBackground,
      double? backgroundRadius,
      Color? borderColor,
      double? borderWidth,
      Color? colorSpin,
      double? sizeSpin,
      String? text,
      TextStyle? textStyle}) async {
    final children = <Widget>[
      SpinKitRing(
        lineWidth: 3.0,
        color: colorSpin ?? Colors.white,
        duration: const Duration(milliseconds: 1000),
        size: sizeSpin ?? 40.0,
      )
    ];
    if (text != null && text.isNotEmpty) {
      children.addAll(<Widget>[
        SizedBox(height: 10.0),
        Text(text,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? regularTextStyle())
      ]);
    }

    showCustomDialog(
        context,
        Center(
          child: Container(
            width: sizeBackground ?? 100.0,
            height: sizeBackground ?? 100.0,
            decoration: BoxDecoration(
              color: colorBackground ?? Colors.grey,
              borderRadius:
                  BorderRadius.all(Radius.circular(backgroundRadius ?? 5.0)),
              border: Border.all(
                color: borderColor ?? Colors.grey,
                width: borderWidth ?? 2.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ));
  }

  Widget _buildDialogTransitionsDefault(
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

  Future<void> hideLoading({bool force = false}) async {
    try {
      if (_context != null) {
        if (Navigator.canPop(_context!)) {
          Navigator.pop(_context!);
        }
      }
    } catch (error) {}
    _forceShowDialog = !force;
  }

  Future<void> hideAppDialog({bool force = false}) async {
    try {
      if (_context != null) {
        if (Navigator.canPop(_context!)) {
          Navigator.pop(_context!);
        }
      }
    } catch (error) {}
    _forceShowDialog = !force;
  }
}
