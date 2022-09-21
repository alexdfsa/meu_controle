import 'package:flutter/material.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/firebase/mappers/bank_mapper.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/hasura/hasura_datasource.dart';
import 'package:meu_controle/modules/financial/infra/interfaces/datasources/i_bank_datasource.dart';

class BankHasuraDatasource extends HasuraDatasource<Bank>
    with BankMapper
    implements IBankDatasource {
  BankHasuraDatasource() : super();

  @override
  Future<List<Bank>> getAll() async {
    List<Bank> resultList = [];
    try {
      var result = await runQuery(sqlGetAll);
      resultList =
          (result['data']['bank'] as List).map((e) => fromMap(e)).toList();
    } on Exception catch (ex, stack) {
      debugPrint(ex.toString());
      Future.error(DatasourceException(
          stack, 'bank_hasura_datasource-getAll', ex, ex.toString()));
    } catch (e, stack) {
      UnknownError(e, stack, 'hasura_datasource-getAll');
    }
    return resultList;
  }

  @override
  Future<bool> delete(String uuid) async {
    bool deleted = false;
    try {
      await runMutation(deleteByUU, variables: {"uuid": uuid});
      debugPrint('deletado');
    } catch (e) {
      debugPrint(e.toString());
    }
    return deleted;
  }

  @override
  Future get(String uuid) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Stream<List>> getStreamList() {
    // TODO: implement getStreamList
    throw UnimplementedError();
  }

  @override
  Future<bool> saveOrUpdate(model) {
    // TODO: implement saveOrUpdate
    throw UnimplementedError();
  }
}

String sqlGetAll = '''
query allBanks {
  bank(order_by: {code: asc}) {
    code
    name
    tenant
    updated
    updatedBy
    uuid
    created
    createdBy
    isActive
  }
}
      ''';

String deleteByUU = '''
mutation runMutation(\$uuid: uuid_comparison_exp = {}) {
  delete_bank(where: {uuid: \$uuid}) {
    affected_rows
  }
}
      ''';
