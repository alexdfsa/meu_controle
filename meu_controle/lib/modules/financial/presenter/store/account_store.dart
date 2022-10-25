// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/domain/usecases/account_uc.dart';
import 'package:meu_controle/modules/financial/domain/usecases/bank_uc.dart';
import 'package:meu_controle/modules/financial/presenter/states/account_state.dart';

typedef Model = Account;
typedef ModelState = AccountState;

class AccountStore extends StreamStore<Failure, ModelState> {
  final AccountUC _uc;
  final BankUC _bankUC = BankUC();

  AccountStore(this._uc) : super(ModelState.initial());

  //Form fields
  final formKey = GlobalKey<FormState>();

  final codeInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final inicialBalanceInputController = TextEditingController();
  final commentsInputController = TextEditingController();
  late Color accountColor;
  late Color selectedColor; // const Color.fromARGB(255, 66, 165, 245);
  List<Bank> bankList = [];
  Bank? selectedBank;
  late String selectedType;

  String? validateField(String? value) {
    debugPrint('validateField');
    if (value != null && value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  updateControllers(Model model) {
    nameInputController.text = model.name;
    commentsInputController.text = model.comments;
    codeInputController.text = model.code;
    inicialBalanceInputController.text = model.inicialBanalce.toString();
    selectedBank = bankList.isEmpty
        ? null
        : bankList.firstWhere((element) => element.uuid == model.uuid);
    accountColor = model.color;
    selectedColor = accountColor;
    selectedType = model.accountType.name;
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

  fetchBankList() async {
    try {
      bankList = await _bankUC.getAll() as List<Bank>;
    } on Failure catch (ex) {
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  updatedModel(Model model) {
    model.bank = selectedBank!.uuid;
    model.name = nameInputController.text;
    model.code = codeInputController.text;
    model.inicialBanalce = double.parse(inicialBalanceInputController.text);
    model.comments = commentsInputController.text;
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
