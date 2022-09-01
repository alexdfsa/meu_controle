import 'package:meu_controle/modules/financial/domain/entities/bank.dart';

class BankState {
  final Bank bank;
  final List<Bank> banks;

  BankState({required this.bank, required this.banks});

  BankState.initial()
      : bank = const Bank(),
        banks = [];

  BankState copyWith({
    Bank? bank,
    List<Bank>? banks,
  }) {
    return BankState(
      bank: bank ?? this.bank,
      banks: banks ?? this.banks,
    );
  }
}
