import 'package:flutter/material.dart';

class PcIcon extends StatelessWidget {
  const PcIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 47,
        width: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: const Text(
          "PC",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
