import 'package:flutter/material.dart';

class ProfileTextButton extends StatelessWidget {
  final String text;
  final Function() press;
  const ProfileTextButton({Key? key, required this.text, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 60.0,
      child: TextButton(
        style: const ButtonStyle(alignment: Alignment.centerLeft),
        onPressed: press,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
