import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 76.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        alignment: Alignment.center,
        width: size,
        height: size,
        color: const Color(0xFFC4C4C4),
        child: const Text(
          "NS",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size * 2 / 5,
          ),
        ),
      ),
    );
  }
}
