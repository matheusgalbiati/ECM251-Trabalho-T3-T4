import 'dart:convert';

import 'package:trabalho_t3_t4/constants.dart';
import 'package:http/http.dart' as http;
import 'package:trabalho_t3_t4/models/game.dart';

class GameAPI {
  static Future getAllGamesIDs() async {
    final response = await http.get(Uri.parse(API_Url + "/jogo/"));

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      return res['codigosDosJogos'];
    } else {
      throw Exception('Não foi possível carregar dados');
    }
  }

  static Future getGameInfo(int id) async {
    final response = await http.get(Uri.parse(API_Url + "/jogo/${id}"));

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      final game = Game(
        userId: res['codigoDoUsuario'],
        name: res['nome'],
        userEmail: '',
        userPassword: '',
        year: res['anoDeLancamento'],
        publisher: res['publisher'],
        indicativeRating: res['clacssificacaoEtaria'],
        platforms: res['plataformas'],
        genders: res['generos'],
        description: res['resumo'],
        urlImage: res['urlImagem'],
      );
      return game;
    } else {
      throw Exception('Não foi possível carregar dados');
    }
  }

  static Future postGame(
      String userId,
      String userEmail,
      String userPassword,
      String name,
      int year,
      String publisher,
      String indicativeRating,
      String urlImage,
      String description,
      List genders,
      List platforms) async {
    final game = Game(
      userId: userId,
      userEmail: userEmail,
      userPassword: userPassword,
      name: name,
      year: year,
      publisher: publisher,
      indicativeRating: indicativeRating,
      description: description,
      platforms: platforms,
      genders: genders,
      urlImage: urlImage,
    );

    final response = await http.post(Uri.parse(API_Url + "/jogo/"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(game.toJson()));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha em criar jogo');
    }
  }
}
