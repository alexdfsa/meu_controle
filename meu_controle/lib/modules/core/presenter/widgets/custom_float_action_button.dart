import 'package:flutter/material.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_show_modal.dart';

class CustomFloatActionButton extends StatelessWidget {
  const CustomFloatActionButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.tooTip,
      required this.children,
      required this.save,
      required this.cancel,
      required this.close})
      : super(key: key);
  final String title;
  final Icon icon;
  final String tooTip;
  final List<Widget> children;
  final VoidCallback save;
  final VoidCallback cancel;
  final VoidCallback close;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.purple,
      hoverColor: Colors.orange,
      elevation: 12,
      highlightElevation: 50,
      hoverElevation: 50,
      onPressed: () {
        ShowModal.show(context, title, children, save, cancel, close);
      },
      tooltip: tooTip,
      child: icon,
    );
  }
}

Widget buildFloatBackButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => Navigator.pop(context),
  );
}

Widget bottomAppBar() {
  return BottomAppBar(
    color: Colors.yellow,
    child: Container(
      height: 50,
    ),
  );
}

buttomStyle() {
  return const ButtonStyle();
}
