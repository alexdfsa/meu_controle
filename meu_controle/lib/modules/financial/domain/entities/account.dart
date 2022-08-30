import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AccountType { carteira, contaCorrente, poupanca, investimento, beneficios }

class Account extends Equatable {
  const Account(
      {this.uuid = '',
      this.bank = '',
      this.inicialBanalce = 0,
      this.name = '',
      this.accountType = AccountType.carteira,
      this.comments = '',
      this.color = const Color.fromARGB(255, 66, 165, 245)});
  final String uuid;
  final String bank;
  final double inicialBanalce;
  final String name;
  final AccountType accountType;
  final Color color;
  final String comments;

  @override
  List<Object?> get props =>
      [uuid, bank, inicialBanalce, name, accountType, color, comments];
}
