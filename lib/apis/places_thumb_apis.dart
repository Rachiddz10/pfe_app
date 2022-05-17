import 'dart:convert';
import '../components/place_thumb.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class PlacesThumbs {

  Future<List<PlaceThumb>> fetchAll(int id, int idNumber) async {
    List<PlaceThumb> listPlacesThumb = [];
    final http.Response response = await http.get(Uri.parse('$kURl/$id/$idNumber/thumb'));
    final http.Response responseMeta = await http.get(Uri.parse('$kURl/$id/$idNumber/meta'));
    var json = jsonDecode(response.body);
    var jsonMeta = jsonDecode(responseMeta.body);
    if (response.statusCode == 200 && responseMeta.statusCode == 200) {
      listPlacesThumb.add(PlaceThumb.fromJson(json, jsonMeta));
      return listPlacesThumb;
    } else {
      throw Exception(' Failed to load Places');
    }
  }
}