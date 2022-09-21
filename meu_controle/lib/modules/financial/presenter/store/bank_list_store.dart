import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_snackbar.dart';
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

  Future<void> delete(BuildContext context, Bank model) async {
    try {
      setLoading(true);
      List<Bank> modelList = state.banks;
      _uc.delete(model.uuid);
      modelList.remove(model);
      /*var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success',
          message: 'This record has been deleted.',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      /*CustomSnackbar(null,
              context: context,
              type: ContentType.success,
              title: 'Success',
              message: 'This record has been deleted.')
          .show();*/
      update(state.copyWith(banks: modelList), force: true);
    } on Failure catch (ex) {
      /*var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Ops!',
          message: ex.errorMessage,
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
      CustomSnackbar(null,
          context: context,
          type: ContentType.success,
          title: 'Success',
          message: 'This record has been deleted.');
      setError(ex);
    } finally {
      setLoading(false);
    }
  }

  unDelete() {}
}
