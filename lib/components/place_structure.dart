import 'package:pfe_app/components/language.dart';
import 'package:pfe_app/components/translation.dart';

class PlaceStructure {
  final int? idPlace;
  final String? name;
  final String? description;
  final String? thumb;
  final int? price;
  final int? time;
  final String? lat;
  final String? long;
  final String? summary;

  PlaceStructure({
    required this.idPlace,
    required this.name,
    required this.description,
    required this.thumb,
    required this.price,
    required this.time,
    required this.lat,
    required this.long,
    required this.summary,
  });

  static Future<PlaceStructure> fromJsonTranslated(int idNum, Map<String, dynamic> json) async {
    String? cityName = json['name'];
    String? cityDescription = json['description'];
    String? citySummary = json['summary'];
    if(Language.language.languageCode == 'fr') {
      if(cityDescription != null) {
        cityDescription = await TranslationAPI.translate(cityDescription, 'fr');
      }
      if(citySummary != null) {
        citySummary = await TranslationAPI.translate(citySummary, 'fr');
      }
    }
    if(Language.language.languageCode == 'ar') {
      if(cityDescription != null) {
        cityDescription = await TranslationAPI.translate(cityDescription, 'ar');
      }
      if(citySummary != null) {
        citySummary = await TranslationAPI.translate(citySummary, 'ar');
      }
    }
    PlaceStructure place = PlaceStructure(
      idPlace: idNum,
      name: cityName,
      description: cityDescription,
      thumb: json['thumb'],
      price: json['meta'][0]['price'],
      time: json['meta'][0]['time'],
      lat: json['geo'][0]['lat'],
      long: json['geo'][0]['long'],
      summary: citySummary,
    );
    return place;
  }
}
