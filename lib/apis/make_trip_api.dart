import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class MakeTripAPI {
  Future<List> makeVoyage(int id, double lat, double long, List list, int time,
      int price, int distance) async {
    http.Response response = await http.post(
      Uri.parse('$kURl/generate-path'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'city': id,
          'lat': lat,
          'long': long,
          'cats': list,
          'time': time,
          'price': price,
          'maxdistance': distance,
        },
      ),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<Map<String, dynamic>> list = [];
      Map<String, dynamic> newMap = Map<String, dynamic>.from(json);
      newMap.entries.map((e) {
        Map<String, dynamic> littleMap = {e.key: e.value};
        list.add(littleMap);
      }).toList();
      return list;
    } else {
      throw Exception('error fetching path');
    }
  }
}
