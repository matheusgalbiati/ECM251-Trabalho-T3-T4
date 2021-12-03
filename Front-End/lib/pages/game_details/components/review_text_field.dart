import 'package:flutter/material.dart';

class ReviewTextField extends StatelessWidget {
  final TextEditingController inputControllerName;
  final String hintText;
  const ReviewTextField({
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
        border: InputBorder.none,
      ),
      maxLines: 5,
    );
  }
}
