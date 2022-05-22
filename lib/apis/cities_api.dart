import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

import '../components/city.dart';
class CitiesApi {
  Future fetchAll() async {
    List<City> listOfCities = [];
    final http.Response response =  await http.get(Uri.parse('$kURl/cities'));
    var json = jsonDecode(response.body);
    if(response.statusCode == 200) {
      for (int i=1;i<= json.length;i++) {
        listOfCities.add(await City.fromJsonTranslated(json[i-1]));
      }
      return listOfCities;
    } else {
      List<City> listOfCities = [];
      listOfCities.add(City(name: 'Error Fetching', id: 0, picture: '/storage/media/placeholder.jpg'));
      return listOfCities;
    }
  }
}
