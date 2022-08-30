import 'package:meu_controle/modules/financial/domain/interfaces/repositories/i_bank_repository.dart';
import 'package:meu_controle/modules/financial/infra/interfaces/datasources/i_bank_datasource.dart';

class BankRepository implements IBankRepository {
  final IBankDatasource _datasource;

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
