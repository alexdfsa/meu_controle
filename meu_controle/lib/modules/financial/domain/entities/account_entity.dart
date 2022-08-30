import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AccountType { carteira, contaCorrente, poupanca, investimento, beneficios }

// ignore: must_be_immutable
abstract class AccountEntity extends Equatable {
  AccountEntity(
      {this.uuid = '',
      this.bank = '',
      this.inicialBanalce = 0,
      this.name = '',
      this.accountType = AccountType.carteira,
      this.comments = '',
      this.color = const Color.fromARGB(255, 66, 165, 245)});
  String uuid;
  String bank;
  double inicialBanalce;
  String name;
  AccountType accountType;
  Color color;
  String comments;

  @override
  List<Object?> get props =>
      [uuid, bank, inicialBanalce, name, accountType, color, comments];
}
