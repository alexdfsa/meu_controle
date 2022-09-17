import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_bottom_navigation_bar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_float_action_button.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_text_form_field.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/presenter/states/bank_state.dart';
import 'package:meu_controle/modules/financial/presenter/store/bank_store.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key, required this.model});

  final Bank model;

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final BankStore store = Modular.get();
  @override
  void initState() {
    super.initState();

    store.updateControllers(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return scopedBuilder();
  }

  Scaffold page() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: store.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Code',
                controller: store.codeInputController,
                validatorType: ValidatorType.mandatoryField,
                textInputType: TextInputType.number,
              ),
              CustomTextFormField(
                label: 'Name',
                controller: store.nameInputController,
                validatorType: ValidatorType.mandatoryField,
                textInputType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatActionButton(
        icon: const Icon(Icons.add),
        tooTip: 'Criar nova banco',
        onPressed: save,
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
        return page();
      },
    );
  }

  void save() {
    if (store.formKey.currentState!.validate()) {
      debugPrint('beforeSave');
      store.saveOrUpdate();
      debugPrint('afterSve');
    }
  }

  void cancel() {
    debugPrint('Clicou em cancel. Before Objeto bank: ${store.state.bank}');
    debugPrint('Clicou em cancel. After Objeto bank: ${store.state.bank}');
    store.codeInputController.text = store.state.bank.code;
    store.nameInputController.text = store.state.bank.name;
  }

  void close() {
    debugPrint('Clicou em close. Before Objeto bank: ${store.state.bank}');
    debugPrint('Clicou em close. After Objeto bank: ${store.state.bank}');
    Navigator.pop(context);
  }
}
