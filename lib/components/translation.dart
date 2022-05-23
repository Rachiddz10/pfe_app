import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';
import 'package:html_unescape/html_unescape.dart';

class TranslationAPI {
  static Future<String> translate(
      String message, String toLanguageCode) async {
    String? api = apiKeyGoogle.data;
    final http.Response response = await http.post(Uri.parse('https://translation.googleapis.com/language/translate/v2?target=$toLanguageCode&key=$api&q=$message'));
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List translated = json['data']['translations'] as List;
      String translatedMessage = translated[0]['translatedText'];
      return HtmlUnescape().convert(translatedMessage);
    } else {
      throw Exception();
    }
  }

  static String getLanguageCode(String language) {
    switch (language) {
      case 'French':
        return 'fr';
      case 'Arabic':
        return 'ar';
      case 'English':
      default:
        return 'en';
    }
  }
}
