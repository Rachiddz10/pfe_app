import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pfe_app/components/place_structure.dart';

import '../components/category_place.dart';

class PlaceCategoryAPI {
  Future<List<ExploreCategory>> fetchPlaceFromCategories(int idCity, List<CategoryPlace> list) async {
    List<ExploreCategory> listOfPlaces = [];
    for (var e in list) {
      final http.Response response = await http.get(Uri.parse('https://pfeweb.ml/REST/filter/$idCity/${e.id}'));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List <PlaceStructure> places = [];
        for (int i = 0; i < json.length; i++) {
          final http.Response response2 = await http.get(Uri.parse('https://www.pfeweb.ml/REST/1/${json[i]['id']}/info'));
          if(response2.statusCode == 200) {
            var json2 = jsonDecode(response2.body);
            places.add(await PlaceStructure.fromJsonTranslated(json[0]['id'], json2));
          } else {
            throw Exception('Error in exploring categories 2');
          }
        }
        listOfPlaces.add(ExploreCategory(e, places));
      }
      else {
        throw Exception('Error in exploring categories');
      }
    }
    return listOfPlaces;
  }
}

class ExploreCategory{
  CategoryPlace? categoryPlace;
  List<PlaceStructure>? listOfPlaces;

  ExploreCategory(this.categoryPlace, this.listOfPlaces);
}