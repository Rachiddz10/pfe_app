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

  static Future<PlaceStructure> fromJsonTranslated(int idNum, Map<String, dynamic> json, List<dynamic> jsonMeta, List<dynamic> jsonGeo, Map<String, dynamic> jsonThumb) async {
    String? cityName = json['name'];
    String? cityDescription = json['description'];
    String? citySummary = jsonThumb['summary'];
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
      price: jsonMeta[0]['price'],
      time: jsonMeta[0]['time'],
      lat: jsonGeo[0]['lat'],
      long: jsonGeo[0]['long'],
      summary: citySummary,
    );
    return place;
  }
}
