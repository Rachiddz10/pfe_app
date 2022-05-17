import 'dart:convert';
import '../components/place_structure.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class PlaceInfo {

  Future<List<PlaceStructure>> fetchAll(int id, int idNumber) async {
    try {
      List<PlaceStructure> listPlacesInfo = [];
      final http.Response response = await http.get(
          Uri.parse('$kURl/$id/$idNumber/info'));
      final http.Response responseMeta = await http.get(
          Uri.parse('$kURl/$id/$idNumber/meta'));
      final http.Response responseGeo = await http.get(
          Uri.parse('$kURl/$id/$idNumber/geo'));
      final http.Response responseThumb = await http.get(
          Uri.parse(('$kURl/$id/$idNumber/thumb')));
      var json = jsonDecode(response.body);
      var jsonMeta = jsonDecode(responseMeta.body);
      var jsonGeo = jsonDecode(responseGeo.body);
      var jsonThumb = jsonDecode(responseThumb.body);
      if (response.statusCode == 200 && responseMeta.statusCode == 200
          && responseGeo.statusCode == 200 && responseThumb.statusCode == 200) {
        listPlacesInfo.add(PlaceStructure.fromJson(
            idNumber, json, jsonMeta, jsonGeo, jsonThumb));
        return listPlacesInfo;
      } else {
        throw Exception(' Failed to load Places');
      }
    } catch (e) {
    List<PlaceStructure> listPlacesInfo = [];
    listPlacesInfo.add(PlaceStructure(idPlace: 0, name: 'Error', description: 'Error Fetching data', thumb: 'storage/media/1652790063.maqam.jpg', price: 0, time: 0, lat: '', long: '', summary: ''));
      return listPlacesInfo;
    }
  }
}