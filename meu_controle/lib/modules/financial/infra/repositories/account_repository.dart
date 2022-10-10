import 'package:meu_controle/modules/financial/domain/interfaces/repositories/i_account_repository.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/hasura/account_hasura_datasource.dart';

class AccountRepository implements IAccountRepository {
  //Select the current Datasource. Para alterar entre
  final AccountHasuraDatasource _datasource;

  AccountRepository(this._datasource);

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
  Future saveOrUpdate(model) {
    return _datasource.saveOrUpdate(model);
  }
}
