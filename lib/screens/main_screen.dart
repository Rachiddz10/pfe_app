import 'package:flutter/material.dart';
import 'package:pfe_app/screens/make_trip.dart';
import 'package:pfe_app/screens/explore.dart';
import 'dart:math';
import 'package:pfe_app/screens/place_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.idNumber}) : super(key: key);
  static const String id = 'main_screen';
  final int? idNumber;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GestureDetector buildCard() {
    var ran = Random();
    var heading = '\$${(ran.nextInt(20) + 15).toString()}00 per month';
    var subheading =
        '${(ran.nextInt(3) + 1).toString()} bed, ${(ran.nextInt(2) + 1).toString()} bath, ${(ran.nextInt(10) + 7).toString()}00 sqft';
    var cardImage = NetworkImage(
        'https://source.unsplash.com/random/800x600?house&' + ran.nextInt(100).toString());
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

  //------- place api ------
  /*dynamic json;
  int? id;
  void initializeData() {
    id = widget.idNumber;
    getPlaces();
  }

  void getPlaces() async {
    json = await PlacesApi().fetchAll(id!);
    List<PlaceNumber> numberOfPlaces = PlacesApi().getAllPlaces(json);
    for (int i = 0; i < json.length; i++) {
      print(numberOfPlaces[i].id);
    }
  }*/

  //-----------------------------------

  /*@override
  void initState() {
    super.initState();
    initializeData();
  }*/

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
                  height: 400.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: buildCard(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: buildCard(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: buildCard(),
                        ),
                      ),
                    ],
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
                    children: [
                      buildCard(),
                      buildCard(),
                      buildCard(),
                      buildCard(),
                      buildCard(),
                      buildCard(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
