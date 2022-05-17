import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

import '../components/place.dart';

class PlacesApi {
  Future<List<Place>> fetchAll(int id) async {
    try {
      List<Place> listOfPlaces = [];
      final http.Response response = await http.get(
          Uri.parse('$kURl/$id/places'));
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (int i = 0; i < json.length; i++) {
          listOfPlaces.add(Place.fromJson(json[i]));
        }
        return listOfPlaces;
      } else {
        throw Exception(' Failed to load Place');
      }
    } catch (e) {
      List<Place> listOfPlaces = [];
      return listOfPlaces;
    }
  }
}