import 'package:flutter_hiennv/services/database/base_repository.dart';
import 'package:flutter_hiennv_example/database/profile_dao.dart';
import 'package:flutter_hiennv_example/database/sqlite_database_provider.dart';
import 'package:flutter_hiennv_example/models/profile.dart';

class ProfileRepository
    extends BaseRepository<SQLiteDatabaseProvider, Profile> {
  final profileDao = ProfileDao();

  ProfileRepository(SQLiteDatabaseProvider databaseProvider)
      : super(databaseProvider);

  @override
  Future<Profile?> delete(Profile entity) async {
    final db = await databaseProvider.get();
    await db!.delete(profileDao.tableName,
        where: profileDao.columnId + " = ?", whereArgs: [entity.id]);
    return entity;
  }

  @override
  Future<List<Profile>> gets() async {
    final db = await databaseProvider.get();
    List<Map<String, dynamic>> maps = await db!.query(profileDao.tableName);
    return profileDao.fromList(maps);
  }

  @override
  Future<Profile?> insert(Profile entity) async {
    final db = await databaseProvider.get();
    await db!.insert(profileDao.tableName, profileDao.toMap(entity));
    return entity;
  }

  @override
  Future<Profile?> update(Profile entity) async {
    final db = await databaseProvider.get();
    await db!.update(profileDao.tableName, profileDao.toMap(entity));
    return entity;
  }

  @override
  Future<Profile?> get(int id) async {
    final db = await databaseProvider.get();
    List<Map<String, dynamic>> maps = await db!.query(profileDao.tableName,
        where: profileDao.columnId + " = ?", whereArgs: [id]);
    return maps.isNotEmpty ? profileDao.fromMap(maps.first) : null;
  }

  @override
  Future<void> clear() async {
    final db = await databaseProvider.get();
    db!.execute("delete from "+ profileDao.tableName);
  }
}
