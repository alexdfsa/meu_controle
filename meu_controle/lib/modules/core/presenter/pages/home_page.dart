import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/modules/app/utils/menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        //leading: ,
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text('Arquivar')),
                    const PopupMenuItem<int>(value: 1, child: Text('Excluir')),
                    const PopupMenuItem<int>(value: 2, child: Text('Ajuda')),
                  ])
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }

  drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text('Meu Controle'),
          ),
          ListTile(
            title: const Text('Banco'),
            onTap: () {
              Modular.to.popAndPushNamed(Menu.financialBankList);
              //Modular.to.pushNamed(Menu.financialBankList);
            },
          ),
          ListTile(
            title: const Text('Conta'),
            onTap: () {
              Modular.to.popAndPushNamed(Menu.financialAccountList);
            },
          ),
          ListTile(
            title: const Text('Categoria'),
            onTap: () {
              Modular.to.popAndPushNamed(Menu.financialCategoryList);
            },
          ),
        ],
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

void handleClick(int item) {
  switch (item) {
    case 0:
      debugPrint('Clicou na ação 1');
      break;
    case 1:
      debugPrint('Clicou na ação 2');
      break;
    case 2:
      debugPrint('Clicou na ação 3');
      break;
  }
}
