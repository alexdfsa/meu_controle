import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_mapper.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';

mixin BankMapper implements Mapper<Bank> {
  @override
  Map<String, dynamic> toMap(Bank bank) {
    return {
      'uuid': bank.uuid,
      'code': bank.code,
      'name': bank.name,
      'created': bank.created,
      'createdBy': bank.createdBy,
      'updated': bank.updated,
      'updatedBy': bank.updatedBy,
      'tenant': bank.tenant,
      'isActive': bank.isActive,
    };
  }

  @override
  Bank fromMap(Map<dynamic, dynamic> map) {
    //Bank bank = Bank.n();
    try {
      Bank bank = Bank(
          uuid: map['uuid'],
          tenant: map['tenant'],
          created: Timestamp.fromDate(DateTime.parse(map['created'])),
          createdBy: map['createdBy'],
          updated: Timestamp.fromDate(DateTime.parse(map['updated'])),
          updatedBy: map['updatedBy'],
          isActive: map['isActive'],
          code: map['code'],
          name: map['name']);
      return bank;
    } catch (e, stacktrace) {
      debugPrint(e.toString());
      throw DatasourceException(
          stacktrace, 'bank_mapper-fromMap', e, e.toString());
    }
  }
}

//Timestamp.fromDate(DateTime.parse(map['created']))
