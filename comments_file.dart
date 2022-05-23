/* this file contain comments of code that may be needed during the realization of this projetc*/

/*GestureDetector buildCard() {
    var ran = Random();
    var heading = '\$${(ran.nextInt(20) + 15).toString()}00 per month';
    var subheading =
        '${(ran.nextInt(3) + 1).toString()} bed, ${(ran.nextInt(2) + 1).toString()} bath, ${(ran.nextInt(10) + 7).toString()}00 sqft';
    var cardImage = NetworkImage(
        'https://source.unsplash.com/random/800x600?house&${ran.nextInt(100).toString()}');
    var supportingText =
        'Beautiful home to rent, recently refurbished with modern appliances...';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PlaceView.id);
      },
      child: Card(
        child: Card(
            elevation: 4.0,
            child: Column(
              children: [
                ListTile(
                  title: Text(heading),
                  subtitle: Text(subheading),
                  trailing: const Icon(Icons.favorite_outline),
                ),
                SizedBox(
                  height: 200.0,
                  child: Ink.image(
                    image: cardImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(supportingText),
                ),
                /*ButtonBar(
                  children: [
                    TextButton(
                      child: const Text('CONTACT AGENT'),
                      onPressed: () {
                        *//* ... *//*
                      },
                    ),
                    TextButton(
                      child: const Text('LEARN MORE'),
                      onPressed: () {
                        *//* ... *//*
                      },
                    )
                  ],
                )*/
              ],
            )),
      ),
    );
  }
  */


/*
//------------- Card Builder Vertical
  List<Widget> buildVerticalCard() {
    List<Widget> listHorizontal = [];
    for (var element in listOfPlaces!) {
      var heading = '${element.name}';
      var subheading = '${element.price} DZD for entry';
      var cardImage = NetworkImage('$kURlForImage/${element.thumb}');
      var supportingText = '${element.summary}';
      listHorizontal.add(
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width - 100.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PlaceView.id);
              },
              child: Card(
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(heading),
                        subtitle: Text(subheading),
                        trailing: const Icon(Icons.favorite_outline),
                      ),
                      SizedBox(
                        height: 200.0,
                        child: Ink.image(
                          image: cardImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(supportingText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return listHorizontal;
  }
 */

/*
//------ PLace Thumb API
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
}*/


/*
//------ PLace Thumb
class PlaceThumb {
  final String? name;
  final String? summary;
  final String? thumb;
  final int? price;
  final int? time;

  PlaceThumb({required this.name, required this.summary, required this.thumb, required this.price, required this.time});

  factory PlaceThumb.fromJson(Map<String, dynamic> json, List<dynamic> jsonMeta) {
    PlaceThumb place = PlaceThumb(
      name: json['name'],
      summary: json['summary'],
      thumb: json['thumb'],
      price: jsonMeta[0]['price'],
      time: jsonMeta[0]['time'],
    );
    return place;
  }
}*/


//----------  image urls  -------------------
/*

//List<String>? images;
images = [
      'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
      'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
      'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
      'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
      'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
      'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
      'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    ];
 */