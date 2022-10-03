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
      var affectedRows = await runMutation(deleteSQL(uuid));
      debugPrint('deletado: $deleted');
      if (affectedRows == -1) {
        return false;
      }
    } on Exception catch (ex, stack) {
      debugPrint('delete--------:$ex');
      Future.error(DatasourceException(
          stack, 'bank_hasura_datasource-delete', ex, ex.toString()));
    } catch (e, stack) {
      Future.error(UnknownError(e, stack, 'bank_hasura_datasource-delete'));
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
  Future<bool> saveOrUpdate(model) async {
    bool saved = false;
    Map<String, dynamic> variables = toMap(model);
    try {
      var affectedRows = await runMutation(insertSQL(model));
      debugPrint('salvo: ========');
      if (affectedRows == -1) {
        return false;
      }
    } on Exception catch (ex, stack) {
      debugPrint(ex.toString());
      Future.error(DatasourceException(
          stack, 'bank_hasura_datasource-getAll', ex, ex.toString()));
    } catch (e, stack) {
      UnknownError(e, stack, 'hasura_datasource-getAll');
    }
    return saved;
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

String deleteSQL(String uuid) => '''
mutation delete {
  delete_bank(where: {uuid: {_eq: "$uuid"}}) {
    affected_rows
  }
}
      ''';

String insertSQL(Bank model) => '''
mutation InsertBank {
  insert_bank(objects: {code: "${model.code}", created: "${model.created.toDate()}", createdBy: "${model.createdBy}", isActive: "${model.isActive}", name: "${model.name}", tenant: "${model.tenant}", updated: "${model.updated.toDate()}", updatedBy: "${model.updatedBy}", uuid: "${model.uuid}"}) {
    affected_rows
  }
}
''';

String updateSQL(Bank model) => '''
mutation updateBank {
  update_bank(where: {uuid: {_eq: "${model.uuid}"}}, _set: {code: "${model.code}", isActive: ${model.isActive}, name: "${model.name}", updated: "${DateTime.now()}", updatedBy: "${model.updatedBy}"}) {
    affected_rows
  }
}
''';
