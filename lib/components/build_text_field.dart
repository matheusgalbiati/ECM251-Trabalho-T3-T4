import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/constants.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController inputControllerName;
  final String hintText;
  const BuildTextField({
    Key? key,
    required this.inputControllerName,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputControllerName,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2),
        ),
      ),
    );
  }
}
