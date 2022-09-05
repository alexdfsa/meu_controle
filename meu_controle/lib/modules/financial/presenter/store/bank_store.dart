import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/domain/usecases/bank_uc.dart';
import 'package:meu_controle/modules/financial/presenter/states/bank_state.dart';

class BankStore extends StreamStore<Failure, BankState> {
  final BankUC _uc;

  BankStore(this._uc) : super(BankState.initial());

  //Form fields
  final formKey = GlobalKey<FormState>();

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

  Future<void> fetchStream() async {
    debugPrint('fetchStream');
    try {
      setLoading(true);
      final stramBanks = await _uc.getStreamList() as Stream<List<Bank>>;
      update(state.copyWith(stramBanks: stramBanks));
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  String? validateField(String? value) {
    debugPrint('validateField');
    if (value != null && value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  changeSelected(Bank? bank) {
    debugPrint('changeSelected');
    try {
      setLoading(true);
      if (bank == null) {
        state.codeInputController.clear();
        state.nameInputController.clear();
      } else {
        state.codeInputController.text == bank.code;
        state.nameInputController.text == bank.name;
      }
      update(state.copyWith(bank: bank), force: true);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }
}
