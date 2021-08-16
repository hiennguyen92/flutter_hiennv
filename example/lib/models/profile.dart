import 'dart:convert';

import 'package:flutter_hiennv/models/base_model.dart';
import 'package:flutter_hiennv/utils/extension.dart';

class Profile extends BaseModel<int> {
  Profile(
      {required int id,
      this.name,
      this.bio,
      this.avatarUrl,
      this.url,
      this.upwork,
      this.description})
      : super(id);

  String? name;
  String? bio;
  String? avatarUrl;
  String? url;
  String? upwork;
  String? description;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json.getInt('id', defaultValue: 0),
        name: json.getString('name'),
        bio: json.getString('bio'),
        avatarUrl: json.getString('avatar_url'),
        url: json.getString('url'),
        upwork: json.getString('upwork'),
        description: json.getString('description'));
  }
}
