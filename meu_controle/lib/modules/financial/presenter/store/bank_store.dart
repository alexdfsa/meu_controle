import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/domain/usecases/bank_uc.dart';
import 'package:meu_controle/modules/financial/presenter/states/bank_state.dart';

class BankStore extends StreamStore<Failure, BankState> {
  final BankUC _uc;

  BankStore(this._uc) : super(BankState.initial());

  Future<void> fetchList() async {
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
}
