import 'package:pfe_app/components/translation.dart';

import 'language.dart';

class Weather {
  int? temp;
  int? humidity;
  String? weatherDescription;
  String? iconURL;
  String? cityName;

  Weather({
    required this.temp,
    required this.humidity,
    required this.weatherDescription,
    required this.iconURL,
    required this.cityName,
  });

  static Future<Weather> fromJsonTranslated(
    int temperature,
    int hum,
    String wea,
    String icon,
    String name,
  ) async {
    String? descriptionTranslated = wea;

    if(Language.language.languageCode == 'fr') {
        descriptionTranslated = await TranslationAPI.translate(descriptionTranslated, 'fr');
    }
    if(Language.language.languageCode == 'ar') {
        descriptionTranslated = await TranslationAPI.translate(descriptionTranslated, 'ar');
    }

    Weather weather = Weather(
      temp: temperature,
      humidity: hum,
      weatherDescription: descriptionTranslated,
      iconURL: icon,
      cityName: name,
    );
    return weather;
  }
}
