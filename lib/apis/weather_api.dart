import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pfe_app/components/place_structure.dart';
import 'package:pfe_app/components/weather.dart';
import '../constants.dart';

class WeatherAPI {
  double? temperature;
  int? temp;
  int? humidity;
  String? weatherDescription;
  String? iconURL;
  String? city;

  Future<Weather> getDataMeteo(PlaceStructure list) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${list.lat}&lon=${list.long}&appid=$apiKeyWeather'));
      if (response.statusCode == 200) {
        String data = response.body;
        temperature = jsonDecode(data)['main']['temp'];
        humidity = jsonDecode(data)['main']['humidity'];
        city = jsonDecode(data)['name'];
        temp = temperature!.toInt();
        weatherDescription = jsonDecode(data)['weather'][0]['description'];
        var condition = jsonDecode(data)['weather'][0]['icon'];
        iconURL = 'http://openweathermap.org/img/wn/$condition@2x.png';
        Weather weather = await Weather.fromJsonTranslated(
            temp!, humidity!, weatherDescription!, iconURL!, city!);
        return weather;
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      Weather weather = Weather(temp: 0, humidity: 0, weatherDescription: 'error', iconURL: '', cityName: '');
      return weather;
    }
  }
}
