import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';
import 'package:meu_controle/modules/financial/domain/usecases/account_uc.dart';
import 'package:meu_controle/modules/financial/presenter/states/account_list_state.dart';

class AccountListStore extends StreamStore<Failure, AccountListState> {
  final AccountUC _uc;

  AccountListStore(this._uc) : super(AccountListState.initial());

  Future<void> fetchList() async {
    try {
      setLoading(true);
      final models = await _uc.getAll() as List<Account>;
      update(state.copyWith(models: models));
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  Future<bool> delete(BuildContext context, Account model) async {
    try {
      setLoading(true);
      List<Account> modelList = state.models;
      bool deleted = await _uc.delete(model.uuid);
      if (deleted) {
        modelList.remove(model);
      }
      update(state.copyWith(models: modelList), force: true);
      return deleted;
    } on Exception catch (ex, trace) {
      setError(StoreException(trace, 'label', ex.toString(), ex.toString()));
      return false;
    } finally {
      setLoading(false);
    }
  }

  unDelete() {
    debugPrint('unDeleted pressed');
  }
}
