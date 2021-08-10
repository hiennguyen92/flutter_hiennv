import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hiennv/services/ui/app_navigation_service.dart';

class AppDialogService {
  BuildContext? _context;

  /// iOS: One time only show been one Dialog
  bool _forceShowDialog = false;

  Future<void> showAppDialog(
      {required BuildContext context,
      String? title,
      String? content,
      String? textButton}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return showAppDialogWithBody(
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

  Future<void> showAppDialogWithBody(BuildContext context, Widget body) async {
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
