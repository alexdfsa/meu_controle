import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/modules/financial/domain/usecases/bank_uc.dart';
import 'package:meu_controle/modules/financial/external/datasources/databases/firebase/bank_datasource.dart';
import 'package:meu_controle/modules/financial/infra/repositories/bank_repository.dart';
import 'package:meu_controle/modules/financial/presenter/pages/account_list_page.dart';
import 'package:meu_controle/modules/financial/presenter/pages/bank_list_page.dart';
import 'package:meu_controle/modules/financial/presenter/store/bank_store.dart';

class FinancialModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  List<Bind> get binds => [
        //Bind.lazySingleton((i) => IBankRepository()),
        Bind.lazySingleton((i) => BankUC()),
        Bind.lazySingleton((i) => BankStore(i())),
        Bind.lazySingleton((i) => BankRepository(i())),
        Bind.lazySingleton((i) => BankDatasource()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/bank', child: (context, args) => const BankListPage()),
        ChildRoute('/account',
            child: (context, args) => const AccountListPage()),
      ];
}
