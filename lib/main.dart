import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pfe_app/components/user.dart';
import 'package:pfe_app/screens/city_screen.dart';
import 'package:pfe_app/screens/explore.dart';
import 'package:pfe_app/screens/filter.dart';
import 'package:pfe_app/screens/gallery.dart';
import 'package:pfe_app/screens/loading_screen.dart';
import 'package:pfe_app/screens/login_screen.dart';
import 'package:pfe_app/screens/main_screen.dart';
import 'package:pfe_app/screens/make_trip.dart';
import 'package:pfe_app/screens/path_screen.dart';
import 'package:pfe_app/screens/place_view.dart';
import 'package:pfe_app/screens/register_screen.dart';
import 'package:pfe_app/screens/see_more.dart';
import 'package:pfe_app/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_app/screens/welcome_screen.dart';
import 'l10n/l10n.dart';


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
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: User.first == '' ? '/' : LoadingScreen.id,
      routes: {
        '/': (context) => const WelcomeScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        CityScreen.id: (context) => const CityScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
        MainScreen.id: (context) => const MainScreen(),
        PlaceView.id: (context) => const PlaceView(),
        Explore.id: (context) => const Explore(),
        MakeTrip.id: (context) => const MakeTrip(),
        Gallery.id: (context) => const Gallery(),
        Filter.id: (context) => const Filter(),
        SeeMore.id: (context) => const SeeMore(),
        PathScreen.id: (context) => const PathScreen(),
        LoadingScreen.id: (context) => const LoadingScreen(),
      },
    );
  }
}
