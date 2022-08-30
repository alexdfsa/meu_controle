import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/core/home/presenter/pages/home_page.dart';
import 'package:meu_controle/core/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: SplashModule()),
        ChildRoute('/home', child: (context, args) => const HomePage()),
      ];
}
