import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class PlacesApi {
  List<Place> listOfPlaces = [];
  Future fetchAll(int id) async {
    final http.Response response = await http.get(Uri.parse('$kURl/$id/places'));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return json;
    } else {
      throw Exception(' Failed to load Place');
    }
  }


  /*Future fetchPlace(int idPlace) async {
    final http.Response response = await http.get(Uri.parse('$kURl/$id/places'));
  }
*/
  List<Place> getAllPlaces(var json) {
    for (int i = 0; i < json.length; i++) {
      listOfPlaces.add(Place.fromJson(json[i]));
    }

    return listOfPlaces;
  }
}

class Place {
  final int id;

  Place({required this.id});

  factory Place.fromJson(Map<String, dynamic> json) {
    Place place = Place(
      id: json['id'],
    );
    return place;
  }
}
