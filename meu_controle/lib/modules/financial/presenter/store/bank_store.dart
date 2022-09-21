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

  final codeInputController = TextEditingController();
  final nameInputController = TextEditingController();

  String? validateField(String? value) {
    debugPrint('validateField');
    if (value != null && value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  updateControllers(Bank model) {
    codeInputController.text = model.code;
    nameInputController.text = model.name;
  }

  fetchModel(Bank model) {
    try {
      update(state.copyWith(bank: model), force: true);
      updateControllers(state.bank);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  updatedModel(Bank model) {
    model.code = codeInputController.text;
    model.name = nameInputController.text;
    return model;
  }

  saveOrUpdate() async {
    try {
      setLoading(true);
      Bank model = updatedModel(state.bank);
      await _uc.saveOrUpdate(model);
      update(state.copyWith(bank: model), force: true);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  Future<void> delete(BuildContext context, Bank model) async {
    try {
      setLoading(true);
      _uc.delete(model.uuid);
      update(state.copyWith(bank: model), force: true);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }
}
