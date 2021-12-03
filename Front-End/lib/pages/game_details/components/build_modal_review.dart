import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trabalho_t3_t4/constants.dart';
import 'package:trabalho_t3_t4/data/review_data.dart';
import 'package:trabalho_t3_t4/models/game.dart';
import 'package:trabalho_t3_t4/models/review.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/review_text_field.dart';
import 'package:trabalho_t3_t4/pages/game_details/game_details_page.dart';

class BuildModalReview extends StatefulWidget {
  final Game game;
  const BuildModalReview({Key? key, required this.game}) : super(key: key);

  @override
  State<BuildModalReview> createState() => _BuildModalReviewState();
}

class _BuildModalReviewState extends State<BuildModalReview> {
  final reviewTextController = TextEditingController();
  double gameRating = 0;

  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.85,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          child: ListView(
            controller: controller,
            children: [
              const Text(
                "Escreva seu Review",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                width: 271 + 70,
                height: 113 + 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: Image.asset("lib/assets/balao.png", scale: 0.1),
                    ),
                    Positioned(
                      left: 36,
                      top: 20,
                      child: Container(
                        width: 208 + 110,
                        height: 68 + 42,
                        child: ReviewTextField(
                          inputControllerName: reviewTextController,
                          hintText: "Escreva seu review aqui...",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Nota:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  RatingBar.builder(
                    itemSize: 36,
                    minRating: 1,
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        gameRating = rating;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancelar"),
                    style: OutlinedButton.styleFrom(
                      primary: kPrimaryColor,
                      side: const BorderSide(width: 1, color: kPrimaryColor),
                      textStyle: const TextStyle(fontSize: 18),
                      minimumSize: const Size(106, 46),
                    ),
                  ),
                  const SizedBox(width: 14),
                  ElevatedButton(
                    onPressed: () {
                      final review = Review(
                        gameId: widget.game.name,
                        userId: 'userId',
                        userEmail: 'userEmail',
                        userPassword: 'userPassword',
                        text: reviewTextController.text,
                        rating: gameRating,
                      );
                      gamesReviews.add(review);
                      final double rating = setRating(gamesReviews);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GameDetailPage(
                                game: widget.game,
                                gameRating: rating.toStringAsFixed(1));
                          },
                        ),
                      );
                    },
                    child: const Text("Postar"),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      textStyle: const TextStyle(fontSize: 18),
                      minimumSize: const Size(106, 46),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  double setRating(gamesReviews) {
    double rating = 0;
    double count = 0;
    for (var item in gamesReviews) {
      if (item.gameId == widget.game.name) {
        rating += item.rating;
        count++;
      }
    }
    return rating / count;
  }
}
