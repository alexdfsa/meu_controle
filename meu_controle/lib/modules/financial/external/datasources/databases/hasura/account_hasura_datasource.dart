import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/mappers/account_mapper.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/hasura/hasura_datasource.dart';
import 'package:meu_controle/modules/financial/infra/interfaces/datasources/i_datasource.dart';

class AccountHasuraDatasource extends HasuraDatasource<Account>
    with AccountMapper
    implements IDatasource {
  AccountHasuraDatasource() : super();

  @override
  Future<List<Account>> getAll() async {
    try {
      List<Account> resultList = [];
      var result = await runQuery(sqlGetAll);
      resultList =
          (result['data']['bank'] as List).map((e) => fromMap(e)).toList();
      return resultList;
    } on Failure {
      rethrow;
    } catch (e, stack) {
      throw UnknownError(e.toString(), stack, 'bank_hasura_datasource-getAll');
    }
  }

  @override
  Future<bool> delete(String uuid) async {
    try {
      var affectedRows = await runMutation(deleteSQL(uuid));
      return true;
    } on Failure {
      rethrow;
    } catch (e, stack) {
      throw UnknownError(e.toString(), stack, 'bank_hasura_datasource-delete');
    }
  }

  @override
  Future get(String uuid) async {
    try {
      var result = await runQuery(sqlGetByUUid(uuid));
      Account model = (result['data']['bank']).map((e) => fromMap(e));
      return model;
    } on Failure {
      rethrow;
    } catch (e, stack) {
      throw UnknownError(e.toString(), stack, 'bank_hasura_datasource-getAll');
    }
  }

  @override
  Future saveOrUpdate(pModel) async {
    Account model = pModel;
    String sql = model.uuid.isEmpty ? insertSQL(model) : updateSQL(model);
    try {
      var result = await runMutation(sql);
      if (model.uuid.isEmpty) {
        model.uuid = result["data"]["insert_bank"]["returning"][0]["uuid"];
      }
      return model;
    } on Failure {
      rethrow;
    } catch (e, stack) {
      throw UnknownError(e.toString(), stack, 'bank_hasura_datasource-getAll');
    }
  }

  @override
  Future<Stream<List>> getStreamList() {
    // TODO: implement getStreamList
    throw UnimplementedError();
  }
}

String sqlGetByUUid(String uuid) => '''
query bank {
  bank(where: {uuid: {_eq: "$uuid"}}) {
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

String insertSQL(Account model) => '''
mutation InsertBank {
  insert_bank(objects: {code: "${model.uuid}", created: "${model.created.toDate()}", createdBy: "${model.createdBy}", isActive: "${model.isActive}", name: "${model.name}", tenant: "${model.tenant}", updated: "${model.updated.toDate()}", updatedBy: "${model.updatedBy}"}) {
    returning {
      uuid
    }
    affected_rows
  }
}
''';

String updateSQL(Account model) => '''
mutation updateBank {
  update_bank(where: {uuid: {_eq: "${model.uuid}"}}, _set: {code: "${model.uuid}", isActive: ${model.isActive}, name: "${model.name}", updated: "${DateTime.now()}", updatedBy: "${model.updatedBy}"}) {
    affected_rows
  }
}
''';
