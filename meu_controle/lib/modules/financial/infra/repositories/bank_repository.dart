import 'package:meu_controle/modules/financial/domain/interfaces/repositories/i_bank_repository.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/hasura/bank_hasura_datasource.dart';

class BankRepository implements IBankRepository {
  //Select the current Datasource. Para alterar entre
  final BankHasuraDatasource _datasource;

  BankRepository(this._datasource);

  @override
  Future<bool> delete(String uuid) {
    return _datasource.delete(uuid);
  }

  @override
  Future get(String uuid) {
    return _datasource.get(uuid);
  }

  @override
  Future<List> getAll() {
    //debugPrint('datasource: $_datasource');
    return _datasource.getAll();
  }

  @override
  Future<Stream<List>> getStreamList() {
    return _datasource.getStreamList();
  }

  @override
  Future<bool> saveOrUpdate(model) {
    return _datasource.saveOrUpdate(model);
  }
}
