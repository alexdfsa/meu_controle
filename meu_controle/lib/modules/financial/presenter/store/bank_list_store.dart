import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/domain/usecases/bank_uc.dart';
import 'package:meu_controle/modules/financial/presenter/states/bank_list_state.dart';

class BankListStore extends StreamStore<Failure, BankListState> {
  final BankUC _uc;

  BankListStore(this._uc) : super(BankListState.initial());

  Future<void> fetchList() async {
    debugPrint('fetchList');
    try {
      setLoading(true);
      final banks = await _uc.getAll() as List<Bank>;
      update(state.copyWith(banks: banks));
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }
}
