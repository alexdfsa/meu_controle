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
    try {
      var result = await hasuraConnect.query(sql,
          headers: headers, variables: variables);
      return result;
    } catch (e, stack) {
      throw UnknownError(e.toString(), stack, 'hasura_datasource-runQuery');
    }
  }

  Future runMutation(String sql, {Map<String, dynamic>? variables}) async {
    try {
      var result = await hasuraConnect.mutation(sql,
          headers: headers, variables: variables);
      return result;
    } catch (e, stack) {
      throw UnknownError(e.toString(), stack, 'hasura_datasource-runMutation');
    }
  }

  subscription(String sql, {Map<String, dynamic>? variables}) async {
    Snapshot snapshot = await hasuraConnect.subscription(sql);
    snapshot.listen((data) {
      debugPrint(data);
    }).onError((err) {
      debugPrint(err);
    });
  }
}
