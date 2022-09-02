import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_bottom_navigation_bar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_float_action_button.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_show_modal.dart';
import 'package:meu_controle/modules/financial/presenter/states/bank_state.dart';
import 'package:meu_controle/modules/financial/presenter/store/bank_store.dart';

class BankPage extends StatefulWidget {
  const BankPage({Key? key}) : super(key: key);

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final BankStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.fetchList();
    //store.fetchStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank'),
      ),
      body: scopedBuilder(),
      floatingActionButton: CustomFloatActionButton(
        title: 'Criar nova banco',
        icon: const Icon(Icons.add),
        tooTip: 'Criar nova banco',
        children: listViewWidgets(),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  scopedBuilder() {
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
                  onTap: () {
                    ShowModal.show(context, 'Alterar banco', listViewWidgets());
                  },
                  contentPadding: const EdgeInsets.all(8),
                ),
              );
            },
          ),
        );
      },
    );
  }

  listViewWidgets() {
    return [
      const Text('sdfsdfsdf modal'),
      const Text('sdfsdfsdf modddddal'),
    ];
  }
}
