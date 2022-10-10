import 'package:meu_controle/modules/financial/domain/entities/account.dart';

class AccountState {
  final Account model;

  AccountState({required this.model});

  AccountState.initial() : model = Account.n();

  AccountState copyWith({
    required Account model,
  }) {
    return AccountState(
      model: model,
    );
  }
}
