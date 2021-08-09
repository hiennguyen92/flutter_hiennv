import 'package:flutter_hiennv/models/base_model.dart';
import 'package:flutter_hiennv/utils/extension.dart';

class User extends BaseModel<int> {
  String name;
  String? avatar;
  String? createdAt;

  User({required int id, required this.name, this.avatar, this.createdAt})
      : super(id);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json.getInt('id', defaultValue: 0),
        name: json.getString('name', defaultValue: ''));
  }

  @override
  String toString() {
    return 'User{ id: $id, name: $name }';
  }
}
