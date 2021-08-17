import 'package:flutter/foundation.dart';

abstract class BaseChangeNotifier with ChangeNotifier {
  bool _mounted = true;

  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_mounted) {
      super.notifyListeners();
    }
  }
}
