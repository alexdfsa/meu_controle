import 'package:flutter/material.dart';

class CustomFloatActionButton extends StatelessWidget {
  const CustomFloatActionButton({
    Key? key,
    required this.icon,
    required this.tooTip,
    required this.onPressed,
  }) : super(key: key);
  final Icon icon;
  final String tooTip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.purple,
      hoverColor: Colors.orange,
      elevation: 12,
      highlightElevation: 50,
      hoverElevation: 50,
      onPressed: onPressed,
      tooltip: tooTip,
      child: icon,
    );
  }
}
