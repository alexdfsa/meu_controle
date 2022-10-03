import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';
import 'package:meu_controle/modules/app/utils/menu.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_bottom_navigation_bar.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_float_action_button.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_snackbar.dart';
import 'package:meu_controle/modules/financial/domain/entities/bank.dart';
import 'package:meu_controle/modules/financial/presenter/pages/bank_page.dart';
import 'package:meu_controle/modules/financial/presenter/states/bank_list_state.dart';
import 'package:meu_controle/modules/financial/presenter/store/bank_list_store.dart';

class BankListPage extends StatefulWidget {
  const BankListPage({Key? key}) : super(key: key);

  @override
  State<BankListPage> createState() => _BankListPageState();
}

class _BankListPageState extends State<BankListPage>
    with TickerProviderStateMixin {
  final BankListStore store = Modular.get();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    store.fetchList();
    /*
    _controller = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
        */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank'),
        actions: [
          IconButton(
              onPressed: () {
                store.fetchList();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: scopedBuilder(),
      floatingActionButton: CustomFloatActionButton(
          icon: const Icon(Icons.add),
          tooTip: 'Criar novo banco',
          onPressed: () {
            Modular.to.pushNamed(Menu.financialBank,
                arguments: BankPageArguments(Bank.n()));
          }),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  scopedBuilder() {
    return ScopedBuilder<BankListStore, Failure, BankListState>.transition(
      store: store,
      /*
      transition: (_, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: _controller, curve: Curves.bounceIn),
          // duration: const Duration(milliseconds: 0),
          child: child,
        );
      },
      */
      transition: (_, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 0),
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
      onState: (context, BankListState state) {
        //_controller.forward();
        return SafeArea(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.banks.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(state.banks[index].name),
                  onTap: () => Modular.to.pushNamed(Menu.financialBank,
                      arguments: BankPageArguments(state.banks[index])),
                  contentPadding: const EdgeInsets.all(8),
                  subtitle: Text(state.banks[index].code),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.archive),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool deleted =
                              await store.delete(context, state.banks[index]);
                          if (deleted) {
                            CustomSnackbar(store.unDelete(),
                                    context: context,
                                    type: ContentType.warning,
                                    title: 'Delete',
                                    message: 'This record has been deleted.')
                                .show();
                          } else {
                            CustomSnackbar(null,
                                    context: context,
                                    type: ContentType.failure,
                                    title: 'Delete',
                                    message:
                                        'The error occurred while trying to delete this record.')
                                .show();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
