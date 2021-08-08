import 'package:flutter/foundation.dart';

abstract class BaseModel {

  @protected
  void copyToProps(Map<String, dynamic> json);

}