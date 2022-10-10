import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_mapper.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';

mixin AccountMapper implements Mapper<Account> {
  @override
  Map<String, dynamic> toMap(Account model) {
    return {
      'uuid': model.uuid,
      'name': model.name,
      'created': model.created.toDate().toString(),
      'createdBy': model.createdBy,
      'updated': model.updated.toDate().toString(),
      'updatedBy': model.updatedBy,
      'tenant': model.tenant,
      'isActive': model.isActive,
    };
  }

  @override
  Account fromMap(Map<dynamic, dynamic> map) {
    //Bank bank = Bank.n();
    try {
      Account model = Account(
        uuid: map['uuid'],
        tenant: map['tenant'],
        created: Timestamp.fromDate(DateTime.parse(map['created'])),
        createdBy: map['createdBy'],
        updated: Timestamp.fromDate(DateTime.parse(map['updated'])),
        updatedBy: map['updatedBy'],
        isActive: map['isActive'],
        name: map['name'],
        bank: map['bank'],
        code: map['code'],
      );
      return model;
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      throw DatasourceException(
          stacktrace, 'bank_mapper-fromMap', e.toString(), e.toString());
    }
  }
}

//Timestamp.fromDate(DateTime.parse(map['created']))
