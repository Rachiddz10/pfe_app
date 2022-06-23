import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe_app/components/place_structure.dart';
import 'package:pfe_app/components/user.dart';

class LikedPlaceAPi {
  Future<bool> getLikedPlaceState(int? idPlace) async {
    final http.Response response = await http.get(
        Uri.parse('https://www.pfeweb.ml/liked?uid=${User.id}&pid=$idPlace'));

    String htmlToParse = response.body;
    if (htmlToParse == 'true') {
      return true;
    } else {
      return false;
    }
  }

  modifyLikedPlaceState(PlaceStructure e) async {
    await http.get(Uri.parse('https://www.pfeweb.ml/like?uid=${User.id}&pid=${e.idPlace}'));
    bool placeState = await getLikedPlaceState(e.idPlace);
    if(placeState == true) {
      e.liked = true;
    } else {
      e.liked = false;
    }
    updateLikedPlaces();
  }

  updateLikedPlaces() async {
    final http.Response response = await http.get(Uri.parse('https://pfeweb.ml/likeList?uid=${User.id}'));
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      User.likedPlaces = [];
      for(int i = 0; i < json.length; i++) {
        User.likedPlaces.add(json[i]['post_id']);
      }
    }
  }
}
