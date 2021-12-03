import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/data/game_data.dart';
import 'package:trabalho_t3_t4/pages/home/components/make_cards.dart';

class MakeCardsList extends StatefulWidget {
  final String title;

  const MakeCardsList({Key? key, required this.title}) : super(key: key);

  @override
  _MakeCardsListState createState() => _MakeCardsListState();
}

class _MakeCardsListState extends State<MakeCardsList> {
  final listController = ScrollController();
  late List games;

  @override
  void initState() {
    super.initState();
    games = gamesInfos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      height: 320,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: scrollBackward,
                      ),
                      TextButton(
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.black),
                        onPressed: scrollForward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 280,
            child: ListView.builder(
              controller: listController,
              padding: const EdgeInsets.all(3),
              scrollDirection: Axis.horizontal,
              itemCount: games.length,
              itemBuilder: (BuildContext context, int index) {
                final game = games[index];
                return Container(
                  child: MakeCard(game: game),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void scrollBackward() {
    final double position = listController.position.pixels;
    listController.animateTo(position - 280,
        duration: const Duration(milliseconds: 320), curve: Curves.easeIn);
  }

  void scrollForward() {
    final double position = listController.position.pixels;
    listController.animateTo(position + 280,
        duration: const Duration(milliseconds: 320), curve: Curves.easeIn);
  }
}
