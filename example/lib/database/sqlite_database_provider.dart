import 'package:flutter_hiennv/services/database/base_database_provider.dart';
import 'package:flutter_hiennv_example/database/profile_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDatabaseProvider extends BaseDatabaseProvider<Database> {
  @override
  Future<Database> init() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hiennv.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(ProfileDao().createTableQuery);
    });
    return db!;
  }
}
