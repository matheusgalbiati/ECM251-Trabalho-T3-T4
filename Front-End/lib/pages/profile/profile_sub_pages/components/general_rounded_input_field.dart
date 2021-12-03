import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/text_field_container.dart';
import 'package:trabalho_t3_t4/constants.dart';

class GeneralRoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool obscure;
  const GeneralRoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: obscure,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
