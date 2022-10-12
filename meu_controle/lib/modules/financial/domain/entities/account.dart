import 'package:flutter/material.dart';
import 'package:meu_controle/modules/core/domain/entities/generic_entity.dart';

enum AccountType { carteira, contaCorrente, poupanca, investimento, beneficios }

class Account extends GenericEntity {
  Account(
      {required super.uuid,
      required super.tenant,
      required super.created,
      required super.createdBy,
      required super.updated,
      required super.updatedBy,
      required super.isActive,
      required this.bank,
      required this.name,
      required this.code,
      this.inicialBanalce = 0,
      this.accountType = AccountType.carteira,
      this.comments = '',
      this.color = const Color.fromARGB(255, 66, 165, 245)});
  String bank;
  String code;
  String name;
  double inicialBanalce;
  AccountType accountType;
  String comments;
  Color color;

  Account.n(
      {this.bank = '',
      this.code = '',
      this.name = '',
      this.inicialBanalce = 0,
      this.accountType = AccountType.carteira,
      this.comments = '',
      this.color = const Color.fromARGB(255, 66, 165, 245)})
      : super.n();

  @override
  List<Object?> get props =>
      [uuid, bank, code, inicialBanalce, name, accountType, color, comments];
}
