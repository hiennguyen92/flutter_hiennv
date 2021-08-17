import 'dart:async';

import 'package:flutter/cupertino.dart';

abstract class BaseDatabaseProvider<T> {
  @protected
  T? db;

  Future<T?> get() async {
    if (db == null) {
      db = await init();
    }
    return db;
  }

  Future<T> init();
}
