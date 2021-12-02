import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/models/review.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/review_card.dart';
import 'package:trabalho_t3_t4/pages/profile/components/profile_image.dart';

class ReviewComponent extends StatelessWidget {
  final Review review;
  const ReviewComponent({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 142,
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            child: ProfileImage(),
          ),
          Positioned(
            top: 8,
            left: 78,
            child: ReviewCard(review: review),
          ),
        ],
      ),
    );
  }
}
