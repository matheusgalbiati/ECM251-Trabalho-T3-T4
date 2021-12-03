import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/my_drawer.dart';
import 'package:trabalho_t3_t4/components/build_text_field.dart';
import 'package:trabalho_t3_t4/components/rounded_button.dart';
import 'package:trabalho_t3_t4/constants.dart';
import 'package:trabalho_t3_t4/data/game_data.dart';
import 'package:trabalho_t3_t4/models/game.dart';
import 'package:trabalho_t3_t4/pages/home/home_page.dart';
import 'package:trabalho_t3_t4/pages/search_game/search_game_page.dart';

class AddGamePage extends StatefulWidget {
  const AddGamePage({Key? key}) : super(key: key);

  @override
  _AddGamePageState createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  final urlImageController = TextEditingController();
  final gameNameController = TextEditingController();
  final gameYearController = TextEditingController();
  final gamePublisherController = TextEditingController();
  final indicativeRateController = TextEditingController();
  final gamePlatformsController = TextEditingController();
  final gameGendersController = TextEditingController();
  var gameGenders = [];
  var gamePlatforms = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 36),
                const Text(
                  "Adicionar novo jogo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 28),
                BuildTextField(
                    inputControllerName: gameNameController,
                    hintText: "Título do jogo"),
                const SizedBox(height: 18),
                BuildTextField(
                    inputControllerName: gameYearController,
                    hintText: "Ano de lançamento"),
                const SizedBox(height: 18),
                BuildTextField(
                    inputControllerName: gamePublisherController,
                    hintText: "Publisher do jogo"),
                const SizedBox(height: 18),
                BuildTextField(
                    inputControllerName: indicativeRateController,
                    hintText: "Classificação indicativa"),
                const SizedBox(height: 18),
                BuildTextField(
                  inputControllerName: gameGendersController,
                  hintText: "Gênero(s) do jogo (separado por vírgula)",
                ),
                const SizedBox(height: 18),
                BuildTextField(
                  inputControllerName: gamePlatformsController,
                  hintText: "Plataforma(s) do jogo (separado por vígula)",
                ),
                const SizedBox(height: 18),
                BuildTextField(
                    inputControllerName: urlImageController,
                    hintText: "Link para a imagem da capa do jogo (opcional)"),
                const SizedBox(height: 36),
                RoundedButton(
                    text: "ADICIONAR",
                    press: () {
                      gameGenders = gameGendersController.text
                          .replaceAll(" ", "")
                          .split(",");
                      gamePlatforms = gamePlatformsController.text
                          .replaceAll(" ", "")
                          .split(",");

                      final newGame = Game(
                        userId: 'userId',
                        name: gameNameController.text,
                        userEmail: 'userEmail',
                        userPassword: 'userPassword',
                        year: int.parse(gameYearController.text),
                        publisher: gamePublisherController.text,
                        indicativeRating: indicativeRateController.text,
                        platforms: gamePlatforms,
                        genders: gameGenders,
                        description: 'description',
                        urlImage: urlImageController.text,
                      );

                      gamesInfos.add(newGame);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                      );

                      /*GameAPI.postGame(
                        'userId',
                        'userEmail',
                        'userPassword',
                        gameNameController.text,
                        int.parse(gameYearController.text),
                        gamePublisherController.text,
                        indicativeRateController.text,
                        urlImageController.text,
                        'description',
                        gameGenders,
                        gamePlatforms,
                      );*/
                    }),
                const SizedBox(height: 4),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  child: const Text("Cancelar"),
                  style: OutlinedButton.styleFrom(
                      primary: kPrimaryColor,
                      side: const BorderSide(width: 1, color: kPrimaryColor),
                      textStyle: const TextStyle(fontSize: 18),
                      minimumSize: Size(size.width * 0.8, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29),
                      )),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
