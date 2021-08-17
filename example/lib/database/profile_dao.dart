import 'package:flutter_hiennv/services/database/base_dao.dart';
import 'package:flutter_hiennv_example/models/profile.dart';

class ProfileDao implements BaseDao<Profile> {
  final tableName = "profiles";

  final columnId = 'id';
  final _columnName = 'name';
  final _columnBio = 'bio';
  final _columnAvatarUrl = 'avatar_url';
  final _columnUrl = 'url';
  final _columnUpwork = 'upwork';
  final _columnDescription = 'description';

  @override
  // TODO: implement createTableQuery
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $_columnName TEXT,"
      " $_columnBio TEXT,"
      " $_columnAvatarUrl TEXT,"
      " $_columnUrl TEXT,"
      " $_columnUpwork TEXT,"
      " $_columnDescription TEXT)";

  @override
  List<Profile> fromList(List<Map<String, dynamic>> query) {
    List<Profile> profiles = <Profile>[];
    for (Map<String, dynamic> map in query) {
      profiles.add(fromMap(map));
    }
    return profiles;
  }

  @override
  Profile fromMap(Map<String, dynamic> query) {
    Profile profile = Profile(id: -1);
    profile.id = query[columnId];
    profile.name = query[_columnName];
    profile.bio = query[_columnBio];
    profile.avatarUrl = query[_columnAvatarUrl];
    profile.url = query[_columnUrl];
    profile.upwork = query[_columnUpwork];
    profile.description = query[_columnDescription];
    return profile;
  }

  @override
  Map<String, dynamic> toMap(Profile object) {
    return <String, dynamic>{
      columnId: object.id,
      _columnName: object.name,
      _columnBio: object.bio,
      _columnAvatarUrl: object.avatarUrl,
      _columnUrl: object.url,
      _columnUpwork: object.upwork,
      _columnDescription: object.description
    };
  }
}
