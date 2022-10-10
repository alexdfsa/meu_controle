import 'package:meu_controle/modules/financial/domain/entities/account.dart';

typedef Model = Account;
typedef ModelList = List<Account>;

class AccountListState {
  final ModelList models;

  AccountListState({required this.models});

  AccountListState.initial() : models = [];

  AccountListState copyWith({
    required ModelList models,
  }) {
    return AccountListState(
      models: models,
    );
  }
}
