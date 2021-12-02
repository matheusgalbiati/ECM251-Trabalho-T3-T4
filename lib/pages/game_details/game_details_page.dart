import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/my_drawer.dart';
import 'package:trabalho_t3_t4/constants.dart';
import 'package:trabalho_t3_t4/models/game.dart';
import 'package:trabalho_t3_t4/pages/game_details/body.dart';
import 'package:trabalho_t3_t4/pages/game_details/components/build_modal_review.dart';
import 'package:trabalho_t3_t4/pages/search_game/search_game_page.dart';

class GameDetailPage extends StatefulWidget {
  final Game game;
  final String gameRating;
  const GameDetailPage({Key? key, required this.game, required this.gameRating})
      : super(key: key);

  @override
  _GameDetailPageState createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Body(game: widget.game, gameRating: widget.gameRating),
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          child: Image.asset(
            "lib/assets/logo.jpg",
            width: 38,
            height: 38,
          ),
        ),
        backgroundColor: const Color(0xFF373C44),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchGamePage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 28),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => BuildModalReview(game: widget.game),
        ),
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
