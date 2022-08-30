abstract class IRepository {
  Future<T> get<T>(String uuid);
  Future<List<T>> getAll<T>();
  Future<bool> saveOrUpdate(model);
  Future<bool> delete(String uuid);
  Future<Stream<List<T>>> getStreamList<T>();
}
