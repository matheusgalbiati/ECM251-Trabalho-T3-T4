import 'package:flutter/material.dart';

class PlaystationIcon extends StatelessWidget {
  const PlaystationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      height: 52,
      child: Image.asset(
        "lib/assets/logoPS5_2.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
