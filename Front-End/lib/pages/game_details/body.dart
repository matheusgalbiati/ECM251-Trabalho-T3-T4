import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/data/review_data.dart';
import 'package:trabalho_t3_t4/models/game.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/game_card.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/indicative_rating.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/plataforms_icons/pc_icon.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/plataforms_icons/playstation_icon.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/plataforms_icons/xbox_icon.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/review_component.dart';
import 'package:trabalho_t3_t4/pages/profile/components/page_divider.dart';

class Body extends StatefulWidget {
  final Game game;
  final String gameRating;
  const Body({Key? key, required this.game, required this.gameRating})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List reviews;

  @override
  void initState() {
    super.initState();
    reviews = gamesReviews
        .where((element) => element.gameId == widget.game.name)
        .toList()
        .reversed
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 18),
            Container(
              child: Row(
                children: [
                  GameCard(imagePath: widget.game.urlImage),
                  const SizedBox(width: 16),
                  Container(
                    height: 178,
                    width: size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.game.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.gameRating,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Text(
                          widget.game.year.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          widget.game.publisher,
                          style: const TextStyle(fontSize: 16),
                        ),
                        IndicativeRating(
                            indicativeRating: widget.game.indicativeRating),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Plataformas:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        height: 52,
                        width: 400,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.game.platforms.length,
                          itemBuilder: (BuildContext context, int index) {
                            final platform = widget.game.platforms[index];
                            return buildPlatform(platform);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Gêneros:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.game.genders.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const PageDivider(),
            const SizedBox(height: 16),
            const Text(
              "Reviews",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: reviews.length,
              itemBuilder: (BuildContext context, int index) {
                final review = reviews[index];
                return ReviewComponent(review: review);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPlatform(platform) {
  if (platform == 'playstation') {
    return Row(
      children: const [
        PlaystationIcon(),
        SizedBox(width: 14),
      ],
    );
  }
  if (platform == 'xbox') {
    return Row(
      children: const [
        XboxIcon(),
        SizedBox(width: 14),
      ],
    );
  }
  if (platform == 'pc') {
    return Row(
      children: const [
        PcIcon(),
        SizedBox(width: 14),
      ],
    );
  }
  return Container();
}
