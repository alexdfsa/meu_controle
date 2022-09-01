import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/financial/presenter/states/bank_state.dart';
import 'package:meu_controle/modules/financial/presenter/store/bank_store.dart';

class BankListPage extends StatefulWidget {
  const BankListPage({Key? key}) : super(key: key);

  @override
  State<BankListPage> createState() => _BankListPageState();
}

class _BankListPageState extends State<BankListPage> {
  final BankStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<BankStore, Failure, BankState>.transition(
      store: store,
      transition: (_, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: child,
        );
      },
      onError: (context, error) {
        debugPrint(error!.errorMessage);
        return Center(
          child: Text(error.errorMessage),
        );
      },
      onLoading: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      onState: (context, BankState state) {
        return SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.banks.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(state.banks[index].name),
                    onTap: () {},
                    contentPadding: const EdgeInsets.all(8),
                  ),
                );
              }),
        );
      },
    );
  }
}
