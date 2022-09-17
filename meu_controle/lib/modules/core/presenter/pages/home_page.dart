import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            button('Navigate to bank Page', '/financial/banklist'),
            button('Navigate to account Page', '/financial/account'),
            button('Navigate to credit card Page', '/financial/creditcard'),
          ],
        ),
      ),
    );
  }
}

button(String title, String menu) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () => Modular.to.pushNamed(menu),
      style: ElevatedButton.styleFrom(
        elevation: 5,
      ),
      child: Text(title),
    ),
  );
}
