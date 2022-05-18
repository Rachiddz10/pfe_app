import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pfe_app/components/place_id.dart';
import 'package:pfe_app/components/place_structure.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/make_trip.dart';
import 'package:pfe_app/screens/explore.dart';
import 'package:pfe_app/screens/place_view.dart';

import '../apis/weather_api.dart';
import '../components/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.idNumber, this.list, this.listOfPlaces})
      : super(key: key);
  static const String id = 'main_screen';
  final int? idNumber;
  final List<PlaceCard>? list;
  final List<PlaceStructure>? listOfPlaces;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  //-----------prepare Weather for nex screen ------
  Weather? weather;
  Future getDataMeteo(PlaceStructure placeStructure) async {
    weather = await WeatherAPI().getDataMeteo(placeStructure);
  }



  //------- City api (id + name) ------
  int? id;
  List<PlaceCard>? list;
  List<PlaceStructure>? listOfPlaces;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    id = widget.idNumber;
    list = widget.list;
    listOfPlaces = widget.listOfPlaces;
  }

  //-----------------------------------

  @override
  Widget build(BuildContext context) {
    if (listOfPlaces!.isEmpty == true) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No places inserted in this town',
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ),
        ),
      );
    } else {
      return Scaffold(
        body: ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.white,
          ),
          inAsyncCall: showSpinner,
          child: SafeArea(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                          child: Material(
                            elevation: 5.0,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, MakeTrip.id);
                              },
                              minWidth: 150.0,
                              height: 50.0,
                              child: const Text(
                                'Make Trip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                          child: Material(
                            elevation: 5.0,
                            //color: Colors.indigo[300],
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Explore.id);
                              },
                              minWidth: 150.0,
                              height: 50.0,
                              child: const Text(
                                'Explore',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 50.0),
                          child: Text(
                            'Nearby Places',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 23.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50.0,
                      height: 440.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: listOfPlaces!
                            .map(
                              (e) => SizedBox(
                                width: MediaQuery.of(context).size.width - 100.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        showSpinner = true;
                                      });
                                      await getDataMeteo(e);


                                      if(!mounted) return;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return PlaceView(
                                          placeInfo: e,
                                          weather: weather,
                                        );
                                      }));
                                      setState(() {
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
                                              subtitle: Text(
                                                  '${e.price} DZD for entry'),
                                              trailing: const Icon(
                                                  Icons.favorite_outline),
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
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 50.0),
                          child: Text(
                            'Popular Places',
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
                        children: listOfPlaces!
                            .map(
                              (e) => GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  await getDataMeteo(e);
                                  if(!mounted) return;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return PlaceView(
                                          placeInfo: e,
                                          weather: weather,
                                        );
                                      }));
                                  setState(() {
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
                                          trailing:
                                              const Icon(Icons.favorite_outline),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
