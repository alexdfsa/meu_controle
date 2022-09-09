import 'package:meu_controle/modules/financial/domain/entities/bank.dart';

class BankState {
  final Bank bank;
  final List<Bank> banks;
  final Stream<List<Bank>> stramBanks;

  BankState(
      {required this.bank, required this.banks, required this.stramBanks});

  BankState.initial()
      : bank = const Bank(),
        banks = [],
        stramBanks = const Stream.empty();

  BankState copyWith({
    Bank? bank,
    List<Bank>? banks,
    Stream<List<Bank>>? stramBanks,
  }) {
    return BankState(
      bank: bank ?? this.bank,
      banks: banks ?? this.banks,
      stramBanks: stramBanks ?? this.stramBanks,
    );
  }
}
