import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/data/review_data.dart';
import 'package:trabalho_t3_t4/models/game.dart';
import 'package:trabalho_t3_t4/pages/game_details/game_details_page.dart';

class MakeCard extends StatefulWidget {
  final Game game;
  const MakeCard({Key? key, required this.game}) : super(key: key);

  @override
  State<MakeCard> createState() => _MakeCardState();
}

class _MakeCardState extends State<MakeCard> {
  late List reviews;
  late double gameRating;

  @override
  void initState() {
    super.initState();
    reviews = gamesReviews;
    gameRating = getRating(reviews);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 272,
      width: 120,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GameDetailPage(
                        game: widget.game,
                        gameRating: gameRating.toStringAsFixed(1),
                      );
                    },
                  ),
                );
              },
              child: Column(
                children: [
                  cardImage(widget.game.urlImage),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(gameRating.toStringAsFixed(1)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(widget.game.name),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  double getRating(List reviews) {
    double rating = 0;
    double count = 0;
    for (var item in reviews) {
      if (item.gameId == widget.game.name) {
        rating += item.rating;
        count++;
      }
    }
    return rating / count;
  }
}
