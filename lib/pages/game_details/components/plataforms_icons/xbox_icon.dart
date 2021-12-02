import 'package:flutter/material.dart';

class XboxIcon extends StatelessWidget {
  const XboxIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      height: 52,
      child: Image.asset(
        "lib/assets/logoXBOX_2.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
