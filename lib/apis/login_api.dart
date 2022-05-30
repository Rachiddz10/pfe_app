import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class LoginAPI {
  Future<dynamic> loginFunction(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse('$kURl/authentification_login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'email': email,
          'password': password,
        },
      ),
    );
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json;
    } else {
      throw Exception('error fetching path');
    }
  }
}
