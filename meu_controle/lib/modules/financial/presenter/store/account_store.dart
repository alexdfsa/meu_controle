import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';
import 'package:meu_controle/modules/financial/domain/usecases/account_uc.dart';
import 'package:meu_controle/modules/financial/presenter/states/account_state.dart';

typedef Model = Account;
typedef ModelState = AccountState;

class AccountStore extends StreamStore<Failure, ModelState> {
  final AccountUC _uc;

  AccountStore(this._uc) : super(ModelState.initial());

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

  updateControllers(Model model) {
    nameInputController.text = model.name;
  }

  fetchModel(Model model) {
    try {
      update(state.copyWith(model: model), force: true);
      updateControllers(state.model);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  updatedModel(Model model) {
    model.name = nameInputController.text;
    return model;
  }

  saveOrUpdate() async {
    try {
      setLoading(true);
      Model model = updatedModel(state.model);
      await _uc.saveOrUpdate(model);
      update(state.copyWith(model: model), force: true);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  Future<void> delete(BuildContext context, Model model) async {
    try {
      setLoading(true);
      _uc.delete(model.uuid);
      update(state.copyWith(model: model), force: true);
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }
}
