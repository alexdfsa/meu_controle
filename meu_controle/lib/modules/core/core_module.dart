import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/core/home/presenter/pages/home_page.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/home', child: (context, args) => const HomePage()),
      ];
}
