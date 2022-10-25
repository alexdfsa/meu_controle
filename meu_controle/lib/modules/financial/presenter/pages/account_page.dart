import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_bottom_navigation_bar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_float_action_button.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_snackbar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_text_form_field.dart';
import 'package:meu_controle/modules/financial/domain/entities/account.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
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
    store.fetchBankList();
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
            Row(
              children: [
                Expanded(
                  child: bankCombo(),
                ),
                /*
                Expanded(
                  child: CustomTextFormField(
                    label: 'Bank',
                    controller: store.codeInputController,
                    validatorType: ValidatorType.mandatoryField,
                    textInputType: TextInputType.number,
                  ),
                ),
                */
                Expanded(
                  child: CustomTextFormField(
                    label: 'Code',
                    controller: store.codeInputController,
                    validatorType: ValidatorType.mandatoryField,
                    textInputType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: dropdownButton(),
                ),
                CircleAvatar(
                  backgroundColor: store.accountColor,
                  radius: 25.0,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(width: 0, color: Colors.transparent),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _openColorPicker(context);
                    },
                    child: const Text(''),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: 'Name',
                    controller: store.nameInputController,
                    validatorType: ValidatorType.mandatoryField,
                    textInputType: TextInputType.text,
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    label: 'Inicial Balance',
                    controller: store.inicialBalanceInputController,
                    validatorType: ValidatorType.mandatoryField,
                    textInputType: TextInputType.number,
                  ),
                ),
              ],
            ),
            CustomTextFormField(
              label: 'Comments',
              controller: store.commentsInputController,
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

  void _openDialog(String title, Widget content, BuildContext context) {
    showDialog(
      context: (context),
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: Navigator.of(_).pop,
              child: const Text('CANCEL'),
            ),
            TextButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                setState(() {
                  store.accountColor = store.selectedColor;
                });
                Navigator.of(_).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker(BuildContext context) async {
    _openDialog(
        "Select a color",
        MaterialColorPicker(
          allowShades: true,
          selectedColor: store.accountColor,
          onColorChange: (color) {
            debugPrint(
                'store.selectedColor: ${store.selectedColor} - color: $color');
            setState(() {
              store.selectedColor = color;
            });
          },
          //onMainColorChange: (color) => store.selectedColor = color as Color,
          onBack: () {},
        ),
        context);
  }

/*
  bankCombo(BuildContext context) {
    return DropdownSearch<Bank>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: getInputDecotation('Banco'),
      ),
      selectedItem: store.state.model.bank,
      asyncItems: (String filter) async {
        return controller.bankList;
      },
      itemAsString: (Bank u) => '${u.code} - ${u.name}',
      onChanged: (Bank? data) {
        if (data != null) {
          store.state.model.bank = data.uuid;
        }
      },
    );
  }
*/
  dropdownButton() {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          //errorText: inicialBalanceError,
          label: Text('Tipo de Conta'),
        ),
        value: store.state.model.accountType.name,
        onChanged: (var newValue) {
          store.selectedType = newValue!;
        },
        items: AccountType.values.map((classType) {
          return DropdownMenuItem<String>(
            value: classType.name,
            child: Text(classType.name),
          );
        }).toList());
  }

  bankCombo() {
    return DropdownSearch<Bank>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: getInputDecotation('Banco'),
      ),
      selectedItem: store.selectedBank,
      asyncItems: (String filter) async {
        return store.bankList;
      },
      itemAsString: (Bank u) => '${u.code} - ${u.name}',
      onChanged: (Bank? data) {
        if (data != null) {
          store.selectedBank = data;
        }
      },
    );
  }

  InputDecoration getInputDecotation(String label) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      //errorText: inicialBalanceError,
      label: Text(label),
    );
  }

  dropdownBank() {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          //errorText: inicialBalanceError,
          label: Text('Banco'),
        ),
        value: store.selectedBank == null
            ? 'Select a bannk'
            : store.selectedBank?.name,
        onChanged: (var newValue) {
          store.selectedType = newValue!;
        },
        items: AccountType.values.map((classType) {
          return DropdownMenuItem<String>(
            value: classType.name,
            child: Text(classType.name),
          );
        }).toList());
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
