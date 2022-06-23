import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/components/nearby_place_info.dart';
import 'package:pfe_app/constants.dart'; 

class NearbyPlacesAPI {
  Future<List<NearbyPlaceInfo>> fetchNearbyPlaces (double long, double lat, int city, double radius) async {
    try {
      List<NearbyPlaceInfo> listOfPlaces = [];
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
        String status = json['status'];
        if(status == 'success') {
          for (int i = 0; i < json.length - 1; i++) {
            listOfPlaces.add(NearbyPlaceInfo.fromJson(json['$i']['id'],json['$i']['distance']));
          }
        } else {
          return [];
        }
        return listOfPlaces;
      } else {
        throw Exception('Failed to load nearby places');
      }
    } catch (e) {
      List<NearbyPlaceInfo> listOfPlaces = [];
      return listOfPlaces;
    }
  }
}