import 'package:flutter/material.dart';
import 'package:pfe_app/screens/splash_screen.dart';

import '../apis/cities_api.dart';

class CityScreen extends StatefulWidget {
  static const String id = 'city_screen';

  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  dynamic json;
  List<MyCard> myCard = [];

  void getCities() async {
    json = await CitiesApi().fetchAll();
    List<City> listOfCities = CitiesApi().getAllCities(json);
    for (int i = 0; i < json.length; i++) {
      myCard.add(MyCard(id: listOfCities[i].id, title: listOfCities[i].name));
    }
  }

  @override
  void initState() {
    super.initState();
    getCities();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        appBar: AppBar(
          title: const Text('Travel'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Text(
                'Choose the city',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: GridView.count(
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  crossAxisCount: 2,
                  children: myCard
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return SplashScreen(idNumber: e.id, name: e.title,);
                            }));
                          },
                          child: Card(
                            elevation: 2.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  e.id.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  e.title,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard {
  final int id;
  //final networkImage;
  final String title;

  MyCard({required this.id, required this.title});
}
