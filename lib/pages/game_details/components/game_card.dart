import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String imagePath;
  const GameCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      height: 178.0,
      child: cardImage(imagePath),
    );
  }

  cardImage(String imagePath) {
    if (imagePath != '') {
      return Image.network(
        imagePath,
        height: 164,
        width: 120,
        fit: BoxFit.cover,
      );
    }
    if (imagePath == '') {
      return Image.asset(
        "lib/assets/noImage.jpg",
        height: 164,
        width: 120,
        fit: BoxFit.cover,
      );
    }
  }
}
