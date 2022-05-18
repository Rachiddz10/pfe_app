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

  factory Weather.fromJson(
    int temperature,
    int hum,
    String wea,
    String icon,
    String name,
  ) {
    Weather weather = Weather(
      temp: temperature,
      humidity: hum,
      weatherDescription: wea,
      iconURL: icon,
      cityName: name,
    );
    return weather;
  }
}
