abstract class GenericDatasource {
  Future get(String uuid);
  Future<List> getAll();
  Future saveOrUpdate(model);
  Future<bool> delete(String uuid);
  Future<Stream<List>> getStreamList();
}
