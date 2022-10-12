import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_bottom_navigation_bar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_float_action_button.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_snackbar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_text_form_field.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';
import 'package:meu_controle/modules/financial/presenter/states/account_state.dart';
import 'package:meu_controle/modules/financial/presenter/store/account_store.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.args});

  final PageArguments args;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AccountStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.fetchModel(widget.args.model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 0, child: Text('Arquivar')),
              const PopupMenuItem<int>(value: 1, child: Text('Excluir')),
              const PopupMenuItem<int>(value: 2, child: Text('Ajuda')),
            ],
          ),
        ],
      ),
      body: page(), //scopedBuildPage(),
      floatingActionButton: scopedBuildFloatActionButton(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  page() {
    return SingleChildScrollView(
      child: Form(
        key: store.formKey,
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Bank',
              controller: store.codeInputController,
              validatorType: ValidatorType.mandatoryField,
              textInputType: TextInputType.number,
            ),
            Row(
              children: [
                CustomTextFormField(
                  label: 'Code',
                  controller: store.codeInputController,
                  validatorType: ValidatorType.mandatoryField,
                  textInputType: TextInputType.number,
                ),
                CustomTextFormField(
                  label: 'Color',
                  controller: store.codeInputController,
                  validatorType: ValidatorType.mandatoryField,
                  textInputType: TextInputType.number,
                ),
              ],
            ),
            CustomTextFormField(
              label: 'Name',
              controller: store.nameInputController,
              validatorType: ValidatorType.mandatoryField,
              textInputType: TextInputType.text,
            ),
            CustomTextFormField(
              label: 'Inicial Balance',
              controller: store.nameInputController,
              validatorType: ValidatorType.mandatoryField,
              textInputType: TextInputType.text,
            ),
            CustomTextFormField(
              label: 'Account Type',
              controller: store.nameInputController,
              validatorType: ValidatorType.mandatoryField,
              textInputType: TextInputType.text,
            ),
            CustomTextFormField(
              label: 'Comments',
              controller: store.nameInputController,
              validatorType: ValidatorType.mandatoryField,
              textInputType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  scopedBuildPage() {
    return ScopedBuilder<AccountStore, Failure, AccountState>.transition(
      store: store,
      /*transition: (_, child) {
        AnimatedOpacity(
          duration: const Duration(
            milliseconds: 400,
          ),
          child: child,
        );*/
/*
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: child,
        );
      },*/
      onError: (context, error) {
        CustomSnackbar(
          null,
          context: context,
          type: ContentType.failure,
          title: 'Ops!',
          message: error == null ? 'Unknown error' : error.errorMessage,
        ).show();
        return Center(
          child: ElevatedButton(
            onPressed: store.fetchModel(widget.args.model),
            child: const Text('Refresh page.'),
          ),
        );
      },
      onLoading: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      onState: (context, AccountState state) {
        return page();
      },
    );
  }

  scopedBuildFloatActionButton() {
    return ScopedBuilder<AccountStore, Failure, AccountState>.transition(
      store: store,
      transition: (_, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 0),
          child: child,
        );
      },
      onError: (context, error) {
        CustomSnackbar(
          null,
          context: context,
          type: ContentType.failure,
          title: 'Ops!',
          message: error == null ? 'Unknown error' : error.errorMessage,
        ).show();
        return CustomFloatActionButton(
          icon: const Icon(Icons.add),
          tooTip: 'Criar nova banco',
          onPressed: () {
            store.saveOrUpdate();
          },
        );
      },
      onLoading: (context) {
        return const CustomFloatActionButton(
          icon: Icon(Icons.charging_station_outlined),
          tooTip: 'Criar nova banco',
          onPressed: null,
        );
      },
      onState: (context, AccountState state) {
        return CustomFloatActionButton(
          icon: const Icon(Icons.add),
          tooTip: 'Criar nova banco',
          onPressed: () async {
            await store.saveOrUpdate();
            CustomSnackbar(null,
                    context: context,
                    type: ContentType.success,
                    title: 'Success',
                    message: 'This record has been saved.')
                .show();
          },
        );
      },
    );
  }
}

void handleClick(int item) {
  switch (item) {
    case 0:
      break;
    case 1:
      break;
  }
}

class PageArguments {
  final Account model;

  PageArguments(this.model);
}
