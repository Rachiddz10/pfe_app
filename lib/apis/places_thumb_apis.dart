import 'dart:convert';
import '../components/place_thumb.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class PlacesThumbs {

  Future<List<PlaceThumb>> fetchAll(int id, int idNumber) async {
    List<PlaceThumb> listPlacesThumb = [];
    final http.Response response = await http.get(Uri.parse('$kURl/$id/$idNumber/thumb'));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      listPlacesThumb.add(PlaceThumb.fromJson(json));
      return listPlacesThumb;
    } else {
      throw Exception(' Failed to load Number of Places');
    }
  }
}