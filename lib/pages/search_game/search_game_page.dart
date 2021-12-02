import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/my_drawer.dart';
import 'package:trabalho_t3_t4/data/game_data.dart';
import 'package:trabalho_t3_t4/data/review_data.dart';
import 'package:trabalho_t3_t4/pages/add_new_game/add_game_page.dart';
import 'package:trabalho_t3_t4/pages/game_details/game_details_page.dart';
import 'package:trabalho_t3_t4/pages/search_game/search_widget.dart';
import 'package:trabalho_t3_t4/models/game.dart';

class SearchGamePage extends StatefulWidget {
  const SearchGamePage({Key? key}) : super(key: key);

  @override
  _SearchGamePageState createState() => _SearchGamePageState();
}

class _SearchGamePageState extends State<SearchGamePage> {
  late List<Game> games = [];
  String query = '';

  @override
  void initState() {
    super.initState();

    games = gamesInfos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
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
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 28),
        ],
      ),
      body: Column(
        children: [
          buildSearch(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AddGamePage();
                  },
                ),
              );
            },
            child: const Text("Adicionar jogo"),
            style: ElevatedButton.styleFrom(primary: const Color(0xFF4DCBA1)),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return buildGame(game);
              },
            ),
          ),
        ],
      ),
    );
  }

  buildSearch() {
    return SearchWidget(
      text: query,
      onChanged: searchGame,
      hintText: 'Nome do jogo ou nome da publisher',
    );
  }

  void searchGame(String query) async {
    final games = gamesInfos.where((game) {
      final nameLower = game.name.toLowerCase();
      final publisherLower = game.publisher.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          publisherLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.games = games;
    });
  }

  Widget buildGame(Game game) {
    return GestureDetector(
      onTap: () {
        double rating = 0;
        double count = 0;
        for (var item in gamesReviews) {
          if (item.gameId == game.name) {
            rating += item.rating;
            count++;
          }
        }
        final double gameRating = rating / count;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return GameDetailPage(
                  game: game, gameRating: gameRating.toStringAsFixed(1));
            },
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              cardImage(game.urlImage),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    game.publisher,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  cardImage(String imagePath) {
    if (imagePath != '') {
      return Image.network(
        imagePath,
        height: 121,
        width: 90,
        fit: BoxFit.cover,
      );
    }
    if (imagePath == '') {
      return Image.asset(
        "lib/assets/noImage.jpg",
        height: 121,
        width: 90,
        fit: BoxFit.cover,
      );
    }
  }
}
