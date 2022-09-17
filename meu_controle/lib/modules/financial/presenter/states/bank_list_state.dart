import 'package:meu_controle/modules/financial/domain/entities/bank.dart';

class BankListState {
  final List<Bank> banks;

  BankListState({required this.banks});

  BankListState.initial() : banks = [];

  BankListState copyWith({
    required List<Bank> banks,
  }) {
    return BankListState(
      banks: banks,
    );
  }
}
