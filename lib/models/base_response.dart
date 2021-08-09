import 'dart:core';
import 'package:flutter/material.dart';

abstract class BaseResponse<T, E> {
  dynamic _raw;
  T? _data;
  E? _error;

  T? get data => _data;
  E? get error => _error;

  BaseResponse(Map<String, dynamic>? json) {
    if (json != null) {
      _raw = json['raw'];
      _data = convertData(json['data'], _raw);
      _error = convertError(json['error'], _raw);
    }
  }

  bool hasError(){
    return error != null;
  }

  @protected
  T? convertData(dynamic dataJson, dynamic raw);

  @protected
  E? convertError(dynamic dataError, dynamic raw);

  @override
  String toString() {
    return 'BaseResponse{ data: $data, error: $error, raw: $_raw }';
  }
}
