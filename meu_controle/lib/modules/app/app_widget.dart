import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Meu Controle',
      theme: ThemeData(primarySwatch: Colors.green),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      builder: (context, child) {
        return Scaffold(
          key: GlobalScaffold.instance.scafoldKey,
          body: child,
        );
      },
    );
  }
}

class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();

  final scafoldKey = GlobalKey<ScaffoldState>();

  void showSnackbar(SnackBar snackBar) {
    ScaffoldMessenger.of(scafoldKey.currentContext!).showSnackBar(snackBar);
  }

  void hideSnackbar(SnackBar snackBar) {
    ScaffoldMessenger.of(scafoldKey.currentContext!).hideCurrentSnackBar();
  }
}
