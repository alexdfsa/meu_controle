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
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: () => Modular.to.pushNamed('/bank'),
              child: const Text('Navigate to bank Page'),
            ),
            ElevatedButton(
              onPressed: () => Modular.to.pushNamed('/account'),
              child: const Text('Navigate to account Page'),
            ),
          ],
        ),
      ),
    );
  }
}
