import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/components/place.dart';
import 'package:pfe_app/constants.dart';

class NearbyPlacesAPI {
  Future<List<Place>> fetchNearbyPlaces (double long, double lat, int city, int radius) async {
    try {
      List<Place> listOfPlaces = [];
      final http.Response response = await http.post(Uri.parse('$kURl/nearby'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'long': long,
            'lat': lat,
            'city': city,
            'radius': radius,
          },
        ),
      );
      if(response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json);
        return listOfPlaces;
      } else {
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      List<Place> listOfPlaces = [];
      return listOfPlaces;
    }
  }
}