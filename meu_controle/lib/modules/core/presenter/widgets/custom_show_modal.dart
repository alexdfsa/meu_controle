import 'package:flutter/material.dart';
import 'package:meu_controle/modules/core/presenter/widgets/custom_draggable_scrollable_sheet.dart';

class ShowModal {
  static show(BuildContext context, String title, List<Widget> children) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return CustomDraggableScrollableSheet(
              title: title, children: children);
        });
  }
}
