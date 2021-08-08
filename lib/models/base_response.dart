import 'dart:core';
import 'package:flutter/material.dart';

class BaseResponse<T, E> {
  dynamic _rawData;
  dynamic _rawError;

  T? _data;
  E? _error;

  T? get data {
    if (_data == null) {
      _data = convertData(_rawData);
    }
    return _data;
  }

  E? get error {
    if (_error == null) {
      _error = convertError(_rawError);
    }
    return _error;
  }

  BaseResponse(Map<String, dynamic>? json,
      {String? dataKey = 'data', String? errorKey = 'error'}) {
    if (json != null) {
      _rawData = dataKey != null ? json[dataKey] : json;
      _rawError = errorKey != null ? json[errorKey] : json;
    }
  }

  // factory BaseResponse.fromError(int errorCode, String message){
  //   Map<String, dynamic> data = {};
  //
  //   return BaseResponse()
  // }
  //
  // factory BaseResponse.fromException(dynamic error){
  //   return BaseResponse()
  // }

  void prepare() {
    if (_data == null) {
      _data = convertData(_rawData);
    }
    if (_error == null) {
      _error = convertError(_rawError);
    }
  }

  void clear() {
    _rawData = null;
    _rawError = null;
  }

  @protected
  T? convertData(dynamic data) {}

  @protected
  E? convertError(dynamic error) {}

  @override
  String toString() {
    return 'BaseResponse{ data: $data, error: $error, dData: $_rawData, dError: $_rawError }';
  }
}