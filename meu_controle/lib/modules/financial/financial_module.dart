import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/modules/financial/domain/usecases/account_uc.dart';
import 'package:meu_controle/modules/financial/domain/usecases/bank_uc.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/hasura/account_hasura_datasource.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/hasura/bank_hasura_datasource.dart';
import 'package:meu_controle/modules/financial/infra/repositories/account_repository.dart';
import 'package:meu_controle/modules/financial/infra/repositories/bank_repository.dart';
import 'package:meu_controle/modules/financial/presenter/pages/account_list_page.dart';
import 'package:meu_controle/modules/financial/presenter/pages/account_page.dart';
import 'package:meu_controle/modules/financial/presenter/pages/bank_page.dart';
import 'package:meu_controle/modules/financial/presenter/store/account_list_store.dart';
import 'package:meu_controle/modules/financial/presenter/store/account_store.dart';
import 'package:meu_controle/modules/financial/presenter/store/bank_list_store.dart';
import 'package:meu_controle/modules/financial/presenter/store/bank_store.dart';

import 'presenter/pages/bank_list_page.dart';

class FinancialModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  List<Bind> get binds => [
        //Bank
        Bind.lazySingleton((i) => BankUC()),
        Bind.lazySingleton((i) => BankStore(i())),
        Bind.lazySingleton((i) => BankListStore(i())),
        Bind.lazySingleton((i) => BankRepository(i())),
        //Bind.lazySingleton((i) => BankFirestoreDatasource()),
        Bind.lazySingleton((i) => BankHasuraDatasource()),

        //Account
        Bind.lazySingleton((i) => AccountUC()),
        Bind.lazySingleton((i) => AccountStore(i())),
        Bind.lazySingleton((i) => AccountListStore(i())),
        Bind.lazySingleton((i) => AccountRepository(i())),
        //Bind.lazySingleton((i) => AccountFirestoreDatasource()),
        Bind.lazySingleton((i) => AccountHasuraDatasource()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/banklist', child: (context, args) => const BankListPage()),
        ChildRoute('/bank',
            child: (context, args) => BankPage(
                  args: args.data,
                )),
        ChildRoute('/accountlist',
            child: (context, args) => const AccountListPage()),
        ChildRoute('/account',
            child: (context, args) => AccountPage(args: args.data)),
      ];
}
