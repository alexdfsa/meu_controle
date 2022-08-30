abstract class GenericRepository {
  Future get(String uuid);
  Future<List> getAll();
  Future<bool> saveOrUpdate(model);
  Future<bool> delete(String uuid);
  Future<Stream<List>> getStreamList();
}
