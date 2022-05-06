import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/gallery.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/core/geo_location.dart';

const apiKey = Text('a1173da81b738a5fdc4ad146f555d9ab');

class PlaceView extends StatefulWidget {
  const PlaceView({Key? key}) : super(key: key);
  static const String id = 'place_view';

  @override
  State<PlaceView> createState() => _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {
  double? temp;

  Location location = Location();

  Future getDataMeteo() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=34.8562728&lon=-1.7312301&appid=a1173da81b738a5fdc4ad146f555d9ab&units=metric'));
    if (response.statusCode == 200) {
      String data = response.body;
      temp = jsonDecode(data)['main']['temp'];
      print(temp);
      return temp;
    } else {
      throw Exception('Failed to load');
    }
  }

  void getLocation() async {
    await location.getCurrentLocation();
    print('latitude = ${location.lat}\nlongitude = ${location.long}');
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getDataMeteo();
  }

  Future<void> refresh() async {
    Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    Navigator.pushNamed(context, PlaceView.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Container(
                          margin: const EdgeInsets.only(left: 30.0, top: 20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,

                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(
                          Icons.keyboard_arrow_left,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                        title: Container(
                          margin: const EdgeInsets.only(top: 20.0, right: 30.0),
                          child: const Text('Mansourah', style: TextStyle(
                            fontSize: 25.0
                          ),),
                        ),
                        trailing: Container(
                          margin: const EdgeInsets.only(top: 20.0, right: 30.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,

                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(
                            Icons.hearing_rounded,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('images/grande.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 5.0,
                        color: const Color(0xFF3F51B5),
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 150.0,
                          height: 42.0,
                          child: const Text(
                            'Visit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 5.0,
                        color: const Color(0xFF3F51B5),
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Gallery.id);
                          },
                          minWidth: 150.0,
                          height: 42.0,
                          child: const Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Card(
                  child: ListTile(
                    leading: const Text(
                      'Mansorah',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //title: Text(temp!.toString()),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.surround_sound_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: kText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
