

import 'package:flutter_hiennv/models/base_model.dart';

class User extends BaseModel {

  int id;
  String name;
  String? avatar;
  String? createdAt;
  User({required this.id, required this.name,  this.avatar, this.createdAt});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String
    );
  }

  @override
  void copyToProps(Map<String, dynamic> json) {
    this.id = json['id'] as int;
    this.name = json['name'] as String;
  }


  @override
  String toString() {
    return 'User{ id: $id, name: $name }';
  }

}