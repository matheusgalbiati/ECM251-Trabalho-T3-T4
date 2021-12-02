import 'dart:convert';

import 'package:trabalho_t3_t4/constants.dart';
import 'package:http/http.dart' as http;
import 'package:trabalho_t3_t4/models/review.dart';

class ReviewAPI {
  static Future getReviews(String gameId) async {
    final response = await http.get(Uri.parse(API_Url + "/review/${gameId}"));

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      return res['reviews'];
    } else {
      throw Exception('Não foi possível carregar dados');
    }
  }

  static Future postReview(String gameId, String userId, String userEmail,
      String userPassword, String text, double rating) async {
    final review = Review(
      gameId: gameId,
      userId: userId,
      userEmail: userEmail,
      userPassword: userPassword,
      text: text,
      rating: rating,
    );

    final response = await http.post(
      Uri.parse(API_Url + "/review/"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(review.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha em postar review');
    }
  }
}
