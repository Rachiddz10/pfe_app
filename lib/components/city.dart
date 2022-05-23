
import 'package:pfe_app/components/language.dart';
import 'package:pfe_app/components/translation.dart';

class City {
  final String? name;
  final int? id;
  final String? picture;

  City({required this.name, required this.id, required this.picture});

  static Future<City> fromJsonTranslated (Map<String, dynamic> json) async {
    String nameCity = json['name'];
    if(Language.language.languageCode == 'ar') {
      nameCity = await TranslationAPI.translate(nameCity, 'ar');
    }
    City city = City(
      id: json['id'],
      name: nameCity,
      picture: json['image'],
    );
    return city;
  }
}
