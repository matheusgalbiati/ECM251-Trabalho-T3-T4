import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 271,
      height: 113,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Image.asset("lib/assets/balao.png"),
          ),
          Positioned(
            left: 32,
            top: 8,
            child: buildRating(review.rating.toInt()),
          ),
          const Positioned(
            top: 8,
            right: 20,
            child: Text(
              "3 Set, 2021",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Positioned(
            left: 36,
            top: 32,
            child: Container(
              width: 208,
              height: 68,
              child: Text(
                review.text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildRating(int rating) {
  switch (rating) {
    case 1:
      return Row(
        children: const [
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18),
          Icon(Icons.star, size: 18),
          Icon(Icons.star, size: 18),
          Icon(Icons.star, size: 18),
        ],
      );
    case 2:
      return Row(
        children: const [
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18),
          Icon(Icons.star, size: 18),
          Icon(Icons.star, size: 18),
        ],
      );
    case 3:
      return Row(
        children: const [
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18),
          Icon(Icons.star, size: 18),
        ],
      );
    case 4:
      return Row(
        children: const [
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18),
        ],
      );
    case 5:
      return Row(
        children: const [
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
          Icon(Icons.star, size: 18, color: Colors.amber),
        ],
      );
    default:
      return Container();
  }
}
