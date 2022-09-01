import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/modules/core/core_module.dart';
import 'package:meu_controle/modules/financial/financial_module.dart';
import 'package:meu_controle/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: SplashModule()),
        ModuleRoute('/core',
            module: CoreModule(), transition: TransitionType.fadeIn),
        ModuleRoute('/financial',
            module: FinancialModule(), transition: TransitionType.fadeIn),
        //ChildRoute('/home', child: (context, args) => const HomePage()),
      ];
}
