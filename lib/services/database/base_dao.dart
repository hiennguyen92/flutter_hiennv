abstract class BaseDao<T> {
  // queries
  String get createTableQuery;

  //mapping methods
  T fromMap(Map<String, dynamic> query);

  List<T> fromList(List<Map<String, dynamic>> query);

  Map<String, dynamic> toMap(T object);
}
