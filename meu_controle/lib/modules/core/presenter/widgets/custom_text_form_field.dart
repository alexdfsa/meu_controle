import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ValidatorType { mandatoryField }

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    required this.validatorType,
    required this.textInputType,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final ValidatorType validatorType;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: ((value) => validate(validatorType, controller.text)),
        onChanged: (value) {
          controller.text = value;
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
        },
        decoration: getInputDecotation(label),
        keyboardType: textInputType,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  InputDecoration getInputDecotation(String label) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      //errorText: inicialBalanceError,
      label: Text(label),
    );
  }

  String? validate(ValidatorType validatorType, String? text) {
    switch (validatorType) {
      case ValidatorType.mandatoryField:
        if (text == null || text.isEmpty) {
          return 'Please field must be filled';
        }
        break;
      default:
    }
    return null;
  }
}
