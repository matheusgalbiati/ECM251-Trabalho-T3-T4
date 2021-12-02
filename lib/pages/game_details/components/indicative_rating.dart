import 'package:flutter/material.dart';

class IndicativeRating extends StatelessWidget {
  final String indicativeRating;
  const IndicativeRating({Key? key, required this.indicativeRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: setColor(indicativeRating),
      ),
      child: Text(
        indicativeRating,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Color setColor(String indicativeRating) {
    Color color;
    switch (indicativeRating) {
      case "L":
        color = Colors.green;
        break;
      case "10":
        color = Colors.blue;
        break;
      case "12":
        color = Colors.yellow;
        break;
      case "14":
        color = Colors.orange;
        break;
      case "16":
        color = Colors.red;
        break;
      case "18":
        color = Colors.black;
        break;
      default:
        color = Colors.grey;
        break;
    }
    return color;
  }
}
