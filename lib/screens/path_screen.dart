import 'package:flutter/material.dart';
import 'package:pfe_app/apis/places_info_api.dart';
import 'package:pfe_app/components/place_structure.dart';
import 'package:pfe_app/screens/place_view.dart';

import '../apis/weather_api.dart';
import '../components/circuit_place.dart';
import '../components/weather.dart';
import '../constants.dart';

class PathScreen extends StatefulWidget {
  const PathScreen({this.listOfPlaces, Key? key}) : super(key: key);
  static const String id = 'path_screen';
  final List<CircuitPlaces>? listOfPlaces;

  @override
  State<PathScreen> createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {

  Weather? weather;

  Future getDataMeteo(PlaceStructure placeStructure) async {
    weather = await WeatherAPI().getDataMeteo(placeStructure);
  }

  List<CircuitPlaces> places = [];
  bool showSpinner = false;

  @override
  initState() {
    super.initState();
    places = widget.listOfPlaces!;
  }
  List<PlaceStructure> listPlaces = [];
  Future getPlaces () async {
    listPlaces = [];
    for (var e in places) {
      listPlaces.add(await PlaceInfo().fetchPlace(1, e.id!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/img_unsplashztpsx.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.green.withOpacity(0.2), BlendMode.saturation),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: places.length == 2
                ? const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
                    child: Card(
                      child: Card(
                        child: Center(
                          child: Text(
                            'No Places available according to the values inserted',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: getPlaces(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25.0, horizontal: 50.0),
                                  child: Text(
                                    ' Circuit',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 23.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: listPlaces
                                    .map(
                                      (e) => GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      await getDataMeteo(e);
                                      if (!mounted) return;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return PlaceView(
                                              placeInfo: e,
                                              weather: weather,
                                            );
                                          }));
                                      setState(() {
                                        listPlaces = listPlaces;
                                        showSpinner = false;
                                      });
                                    },
                                    child: Card(
                                      child: Card(
                                        elevation: 4.0,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(e.name!),
                                              subtitle:
                                              Text('${e.price} DZD for entry'),
                                            ),
                                            SizedBox(
                                              height: 200.0,
                                              child: Ink.image(
                                                image: NetworkImage(
                                                    '$kURlForImage/${e.thumb}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(16.0),
                                              alignment: Alignment.centerLeft,
                                              child: Text('${e.summary}'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25.0, horizontal: 50.0),
                                  child: Text(
                                    ' Circuit',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 23.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 200.0, left: 60.0, right: 60.0),
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}


