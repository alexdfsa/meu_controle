import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/modules/splash/presenter/splash_store.dart';

import 'presenter/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SplashPage()),
  ];
}
