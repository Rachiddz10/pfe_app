import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class RegisterAPI {
  Future<String> registerFunction(String first, String last, String email, String password, int birthday, String gender) async {
    http.Response response = await http.post(
      Uri.parse('$kURl/authentification_register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'first': first,
          'last': last,
          'email': email,
          'password': password,
          'birth': birthday,
          'gender': gender,
        },
      ),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json['message'];
    } else {
      throw Exception('error fetching path');
    }
  }
}