import 'dart:convert';

import 'package:trabalho_t3_t4/constants.dart';
import 'package:http/http.dart' as http;
import 'package:trabalho_t3_t4/models/user.dart';

class UserAPI {
  static Future postUser(
      String firstName, String lastName, String email, String password) async {
    final user = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);

    final response = await http.post(
      Uri.parse(API_Url + "/usuario/"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao registrar usuario');
    }
  }

  static Future getUserData(String id) async {
    final response = await http.get(Uri.parse(API_Url + "/usuario/${id}"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Não foi possível carregar dados');
    }
  }

  static Future updateUserData(
      String userId, String name, String email, String password) async {
    final response = await http.put(
      Uri.parse(API_Url + "/usuario/"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'codigo': userId,
        'nome': name,
        'email': email,
        'senha': password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao atualizar informação');
    }
  }
}
