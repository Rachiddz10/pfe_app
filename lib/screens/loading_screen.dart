import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pfe_app/screens/city_screen.dart';

import '../apis/cities_api.dart';
import '../components/city.dart';
import '../components/language.dart';
import '../components/my_card.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static const String id = 'loading_screen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  dynamic json;
  List<MyCard> myCard = [];

  void getCities() async {
    myCard = [];
    List<City> listOfCities = await CitiesApi().fetchAll();
    for (int i = 0; i < listOfCities.length; i++) {
      myCard.add(MyCard(id: listOfCities[i].id, title: listOfCities[i].name, image: listOfCities[i].picture));
    }
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CityScreen(list: myCard)));
  }

  @override
  void initState() {
    super.initState();
    getCities();
  }

  @override
  Widget build(BuildContext context) {
    Language.setLanguage(Localizations.localeOf(context));
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
          child: const Center(
            child: SpinKitSpinningLines(
              color: Colors.black,
              size: 100.0,
            ),
          ),
        ),
      ),
    );
  }
}
