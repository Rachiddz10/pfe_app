import 'dart:convert';
import 'package:pfe_app/components/gallery_class.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class GalleryAPI {

  Future<List<GalleryClass>> fetchAll(int idNumber) async {
    try {
      List<GalleryClass> listGallery = [];
      final http.Response response = await http.get(
          Uri.parse('$kURl/1/$idNumber/gallery'));
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (int i = 0; i < json.length; i++) {
          listGallery.add(GalleryClass.fromJson(json[i]));
        }
        return listGallery;
      } else {
        throw Exception(' Failed to load gallery');
      }
    } catch (e) {
      List<GalleryClass> listGallery = [];
      listGallery.add(GalleryClass(id: 0, type: 'Error', uri: '/storage/media/1653236691.fichier_produit_329.jpg', title: 'null',));
      return listGallery;
    }
  }
}