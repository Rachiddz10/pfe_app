import 'package:flutter/material.dart';
import 'package:pfe_app/screens/explore.dart';
import 'package:pfe_app/screens/filter.dart';
import 'package:pfe_app/screens/gallery.dart';
import 'package:pfe_app/screens/main_screen.dart';
import 'package:pfe_app/screens/make_trip.dart';
import 'package:pfe_app/screens/path_screen.dart';
import 'package:pfe_app/screens/place_view.dart';
import 'package:pfe_app/screens/see_more.dart';
import 'package:pfe_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visit Tlemcen',
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context) => const SplashScreen(),
        MainScreen.id : (context) => const MainScreen(),
        PlaceView.id : (context) => const PlaceView(),
        Explore.id : (context) => const Explore(),
        MakeTrip.id : (context) => const MakeTrip(),
        Gallery.id : (context) => const Gallery(),
        Filter.id : (context) => const Filter(),
        SeeMore.id : (context) => const SeeMore(),
        PathScreen.id : (context) => const PathScreen(),
      },
    );
  }
}
