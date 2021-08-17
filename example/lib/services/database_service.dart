import 'package:flutter_hiennv_example/database/profile_repository.dart';
import 'package:flutter_hiennv_example/database/sqlite_database_provider.dart';
import 'package:flutter_hiennv_example/models/profile.dart';

class DatabaseService {

  final profileRepository = ProfileRepository(SQLiteDatabaseProvider());


  Future<Profile?> addProfileToDB(Profile profile) async {
    return await profileRepository.insert(profile);
  }


  Future<List<Profile>> getProfiles() async {
    return await profileRepository.gets();
  }

}