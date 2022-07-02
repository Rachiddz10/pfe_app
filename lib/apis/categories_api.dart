import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

import '../components/category_place.dart';

class CategoriesPlacesAPI {
  Future<List<CategoryPlace>> fetchCategories() async {
    List<CategoryPlace> listOfCategories = [];
    final http.Response response =
        await http.get(Uri.parse('$kURl/categories'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (int i = 0; i < json.length; i++) {
        listOfCategories.add(CategoryPlace.fromJson(json[i]));
      }
      return listOfCategories;
    } else {
      throw Exception('categories not received');
    }
  }
}
