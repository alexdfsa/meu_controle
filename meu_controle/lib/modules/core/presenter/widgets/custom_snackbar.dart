import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:meu_controle/modules/app/app_widget.dart';

class CustomSnackbar {
  final BuildContext context;
  final ContentType type;
  final String title;
  final String message;
  final VoidCallback? undoFunction;

  CustomSnackbar(this.undoFunction,
      {required this.context,
      required this.type,
      required this.title,
      required this.message});

  show() {
    var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: snackBarAction,
      ),
    );
    //ScaffoldMessenger.of(context).hideCurrentSnackBar();
    GlobalScaffold.instance.showSnackbar(snackBar);
  }

  snackBarAction() {
    if (undoFunction != null) {
      return SnackBarAction(
        label: 'Undo',
        onPressed: undoFunction!,
      );
    }
    return null;
  }
}
