import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_mapper.dart';

abstract class HasuraDatasource<T extends GenericEntity> extends Mapper<T> {
  HasuraConnect hasuraConnect =
      HasuraConnect('https://alexdfsa-007.hasura.app/v1/graphql');
  Map<String, String> headers = {
    'x-hasura-admin-secret':
        'TxBcNPELr1yeVoZ17nHGMOwjyx2uccTjIvzCy5fghbLrZdi4s3aD88ffhW1HUqZL'
  };

  Future runQuery(String sql, {Map<String, dynamic>? variables}) async {
    List<T> resultList = [];
    try {
      var result = await hasuraConnect.query(sql,
          headers: headers, variables: variables);
      return result;
    } on Exception catch (ex, stack) {
      debugPrint(ex.toString());
      Future.error(DatasourceException(
          stack, 'hasura_datasource-queryGetAll', ex, ex.toString()));
    } catch (e, stack) {
      UnknownError(e, stack, 'hasura_datasource-queryGetAll');
    }
    return resultList;
  }

  Future runMutation(String sql, {Map<String, dynamic>? variables}) async {
    int affectedRows = 0;
    try {
      var result = await hasuraConnect.mutation(sql,
          headers: headers, variables: variables);
      return result;
    } on Exception catch (ex, stack) {
      debugPrint(ex.toString());
      Future.error(DatasourceException(
          stack, 'hasura_datasource-queryGetAll', ex, ex.toString()));
    } catch (e, stack) {
      UnknownError(e, stack, 'hasura_datasource-queryGetAll');
    }
    return affectedRows;
  }
}
