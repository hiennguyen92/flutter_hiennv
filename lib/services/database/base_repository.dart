import 'package:flutter_hiennv/models/base_model.dart';
import 'package:flutter_hiennv/services/database/base_database_provider.dart';

abstract class BaseRepository<T extends BaseDatabaseProvider, E extends BaseModel> {

  T databaseProvider;

  BaseRepository(this.databaseProvider);

  Future<E?> insert(E entity);

  Future<E?> update(E entity);

  Future<E?> delete(E entity);

  Future<List<E>> gets();

  Future<E?> get(int id);

  Future<void> clear();

}