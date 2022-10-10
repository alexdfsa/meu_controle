import 'package:meu_controle/modules/financial/domain/entities/account.dart';

class AccountListState {
  final List<Account> models;

  AccountListState({required this.models});

  AccountListState.initial() : models = [];

  AccountListState copyWith({
    required List<Account> models,
  }) {
    return AccountListState(
      models: models,
    );
  }
}
