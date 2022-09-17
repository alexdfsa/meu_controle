import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/app/utils/string_utils.dart';
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

  updateModel() {
    try {
      setLoading(true);
      Bank model = Bank(
        code: codeInputController.text,
        name: nameInputController.text,
      );
      update(state.copyWith(bank: model), force: true);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  saveOrUpdate() {
    try {
      setLoading(true);
      updateModel();
      Bank model = state.bank;
      if (model.uuid.isEmpty) {
        //TODO: remover o == para parar de dar erro na criação de novos registros;
        model.uuid == StringUtils.generateUUID();
      }
      _uc.saveOrUpdate(model);
      update(state.copyWith(bank: model), force: true);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }
}
