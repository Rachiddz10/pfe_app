import 'dart:convert';
import '../components/place_structure.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class PlaceInfo {

  Future<List<PlaceStructure>> fetchAll(int id, int idNumber) async {
    //try {
      List<PlaceStructure> listPlacesInfo = [];
      final http.Response response = await http.get(
          Uri.parse('$kURl/$id/$idNumber/info'));
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        listPlacesInfo.add(await PlaceStructure.fromJsonTranslated(
            idNumber, json));
        return listPlacesInfo;
      } else {
        throw Exception(' Failed to load Places');
      }
    }/* catch (e) {
    List<PlaceStructure> listPlacesInfo = [];
    listPlacesInfo.add(PlaceStructure(idPlace: 0, name: 'Error', description: 'Error Fetching data', thumb: 'storage/media/1652570202_fichier_produit_21.jpg', price: 0, time: 0, lat: '', long: '', summary: ''));
      return listPlacesInfo;
    }
  }*/
  Future<PlaceStructure> fetchPlace(int id, int idNumber) async {
    //try {
    PlaceStructure listPlacesInfo;
    final http.Response response = await http.get(
        Uri.parse('$kURl/$id/$idNumber/info'));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      listPlacesInfo = await PlaceStructure.fromJsonTranslated(
          idNumber, json);
      return listPlacesInfo;
    } else {
      throw Exception(' Failed to load Places');
    }
  }
}