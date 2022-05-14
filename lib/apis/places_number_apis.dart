/*import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class PlacesApi {
  List<PlaceNumber> numberOfPlaces = [];

  Future fetchAll(int id) async {
    final http.Response response = await http.get(Uri.parse('$kURl/$id/places'));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return json;
    } else {
      throw Exception(' Failed to load Number of Places');
    }
  }


  /*Future fetchPlace(int idPlace) async {
    final http.Response response = await http.get(Uri.parse('$kURl/$id/places'));
  }
*/
  List<PlaceNumber> getAllPlaces(var json) {
    for (int i = 1; i <= json.length; i++) {
      numberOfPlaces.add(PlaceNumber.fromJson(json[i - 1]));
    }

    return numberOfPlaces;
  }
}

class PlaceNumber {
  final int id;

  PlaceNumber({required this.id});

  factory PlaceNumber.fromJson(Map<String, dynamic> json) {
    PlaceNumber place = PlaceNumber(
      id: json['id'],
    );
    return place;
  }
}
*/