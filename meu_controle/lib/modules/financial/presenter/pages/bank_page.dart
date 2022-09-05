import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_bottom_navigation_bar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_float_action_button.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_show_modal.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_text_form_field.dart';
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
        save: save,
        cancel: cancel,
        close: close,
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
                    debugPrint('Page onState onTap');
                    debugPrint(
                        'Clicou em index. Before Objeto bank: ${store.state.bank}');
                    store.changeSelected(state.banks[index]);
                    debugPrint(
                        'Clicou em index. Afeter Objeto bank: ${store.state.bank}');
                    ShowModal.show(context, 'Alterar banco', listViewWidgets(),
                        save, cancel, close);
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

  void save() {
    if (store.formKey.currentState!.validate()) {
      debugPrint(
          'Clicou em salvar. Before change - Objeto bank: ${store.state.bank}');
      store.changeSelected(null);
      debugPrint(
          'Clicou em salvar. Afeter change - Objeto bank: ${store.state.bank}');
      Navigator.pop(context);
    }
  }

  void cancel() {
    debugPrint('Clicou em cancel. Before Objeto bank: ${store.state.bank}');
    store.changeSelected(store.state.bank);
    debugPrint('Clicou em cancel. After Objeto bank: ${store.state.bank}');
    store.state.codeInputController.text = store.state.bank.code;
    store.state.nameInputController.text = store.state.bank.name;
  }

  void close() {
    debugPrint('Clicou em close. Before Objeto bank: ${store.state.bank}');
    store.changeSelected(null);
    debugPrint('Clicou em close. After Objeto bank: ${store.state.bank}');
    Navigator.pop(context);
  }

  listViewWidgets() {
    store.state.codeInputController.text = store.state.bank.code;
    store.state.nameInputController.text = store.state.bank.name;
    return [
      Form(
        key: store.formKey,
        child: Column(
          children: [
            CustomTextFormField(
                label: 'Code',
                controller: store.state.codeInputController,
                validatorType: ValidatorType.mandatoryField),
            CustomTextFormField(
                label: 'Name',
                controller: store.state.nameInputController,
                validatorType: ValidatorType.mandatoryField),
          ],
        ),
      ),
    ];
  }
}
