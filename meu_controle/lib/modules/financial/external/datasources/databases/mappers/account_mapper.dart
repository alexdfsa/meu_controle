import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_mapper.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';

mixin AccountMapper implements Mapper<Account> {
  @override
  Map<String, dynamic> toMap(Account model) {
    try {
      return {
        'uuid': model.uuid,
        'tenant': model.tenant,
        'created': model.created.toDate().toString(),
        'createdBy': model.createdBy,
        'updated': model.updated.toDate().toString(),
        'updatedBy': model.updatedBy,
        'isActive': model.isActive,
        'bank': model.bank,
        'name': model.name,
        'code': model.code,
        'inicialBanalce': model.inicialBanalce,
        'accountType': model.accountType,
        'comments': model.comments,
        'color': model.color
      };
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      throw DatasourceException(
          stacktrace, 'account_mapper-toMap', e.toString(), e.toString());
    }
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
        bank: map['bank'],
        name: map['name'],
        code: map['code'],
        inicialBanalce: map['inicialBanalce'],
        accountType: map['accountType'],
        comments: map['comments'],
        color: map['color'],
      );
      return model;
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      throw DatasourceException(
          stacktrace, 'account_mapper-fromMap', e.toString(), e.toString());
    }
  }
}
