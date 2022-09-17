import 'package:meu_controle/modules/financial/domain/entities/bank.dart';

class BankState {
  final Bank bank;

  BankState({required this.bank});

  BankState.initial() : bank = const Bank();

  BankState copyWith({
    required Bank bank,
  }) {
    return BankState(
      bank: bank,
    );
  }
}
