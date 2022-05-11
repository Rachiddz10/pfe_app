import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';
class CitiesApi {

  List<City> listOfCities = [];

  Future fetchAll() async {
    final http.Response response =  await http.get(Uri.parse('$kURl/cities'));
    var json = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return json;
    } else {
      throw Exception(' Failed to load City');
    }
  }

  List<City> getAllCities (var json) {
    for (int i=1;i<= json.length;i++) {
      listOfCities.add(City.fromJson(json[i-1]));
    }

    return listOfCities;
  }
}



class City {
  final String name;
  final int id;

  City({required this.name,required this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    City city = City(
      id: json['id'],
      name: json['Name'],
    );
    return city;
  }
}

