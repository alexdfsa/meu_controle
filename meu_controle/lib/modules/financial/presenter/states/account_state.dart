import 'package:meu_controle/modules/financial/domain/entities/account.dart';

typedef Model = Account;

class AccountState {
  final Model model;

  AccountState({required this.model});

  AccountState.initial() : model = Account.n();

  AccountState copyWith({
    required Model model,
  }) {
    return AccountState(
      model: model,
    );
  }
}
