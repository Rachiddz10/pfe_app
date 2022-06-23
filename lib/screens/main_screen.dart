import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pfe_app/apis/like_place_api.dart';
import 'package:pfe_app/components/nearby_place_info.dart';
import 'package:pfe_app/components/place_id.dart';
import 'package:pfe_app/components/place_structure.dart';
import 'package:pfe_app/components/user.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/make_trip.dart';
import 'package:pfe_app/screens/place_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_app/screens/welcome_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../apis/weather_api.dart';
import '../components/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {Key? key,
      this.idNumber,
      this.list,
      this.listOfPlaces,
      this.nearbyPlaces,
      this.idsNearbyPlaces})
      : super(key: key);
  static const String id = 'main_screen';
  final int? idNumber;
  final List<PlaceCard>? list;
  final List<PlaceStructure>? listOfPlaces;
  final List<PlaceStructure>? nearbyPlaces;
  final List<NearbyPlaceInfo>? idsNearbyPlaces;

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
  List<PlaceStructure>? listOfNearbyPlaces;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    id = widget.idNumber;
    list = widget.list;
    listOfPlaces = widget.listOfPlaces;
    listOfNearbyPlaces = widget.nearbyPlaces;
  }

  //-----------------------------------

  @override
  Widget build(BuildContext context) {
    if (listOfPlaces!.isEmpty == true) {
      return const MainScreenEmptyPlaces();
    } else if (User.first != '') {
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
                    User.last == ''
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: TextField(
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black54,
                                ),
                                hintText: AppLocalizations.of(context)!.search,
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListTile(
                            title: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: TextField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.black54,
                                  ),
                                  hintText:
                                      AppLocalizations.of(context)!.search,
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            trailing: Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(5.0),
                              child: MaterialButton(
                                minWidth: 15,
                                onPressed: () {
                                  Alert(
                                    context: context,
                                    title: 'Are you sure you want to log out?',
                                    buttons: [
                                      DialogButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      DialogButton(
                                        onPressed: () {
                                          User.logoutUser();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const WelcomeScreen()));
                                        },
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ).show();
                                },
                                child: const Icon(Icons.logout_outlined),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 8.0),
                          child: Material(
                            elevation: 5.0,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                    builder: (context) => const MakeTrip(),
                                  ),
                                );
                              },
                              minWidth: 150.0,
                              height: 50.0,
                              child: Text(
                                AppLocalizations.of(context)!.makeTrip,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 8.0),
                          child: Material(
                            elevation: 5.0,
                            //color: Colors.indigo[300],
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, WelcomeScreen.id);
                              },
                              minWidth: 150.0,
                              height: 50.0,
                              child: Text(
                                AppLocalizations.of(context)!.explore,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (listOfNearbyPlaces!.isNotEmpty)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 50.0),
                            child: Text(
                              AppLocalizations.of(context)!.nearbyPlaces,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (listOfNearbyPlaces!.isNotEmpty)
                      if (listOfNearbyPlaces!.length == 1)
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 460.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: listOfNearbyPlaces!
                                .map(
                                  (e) => SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            showSpinner = true;
                                          });

                                          await getDataMeteo(e);
                                          if (!mounted) return;
                                          await Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PlaceView(
                                              placeInfo: e,
                                              weather: weather,
                                            );
                                          }));
                                          setState(() {
                                            listOfNearbyPlaces =
                                                listOfNearbyPlaces;
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
                                                      '${e.price} ${AppLocalizations.of(context)!.pricing}'),
                                                  trailing: GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        showSpinner = true;
                                                      });
                                                      await LikedPlaceAPi()
                                                          .modifyLikedPlaceState(
                                                              e);
                                                      setState(() {
                                                        if (e.liked == true) {}
                                                        showSpinner = false;
                                                      });
                                                    },
                                                    child: Icon(
                                                      (e.liked == true)
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: (e.liked == true)
                                                          ? Colors.red
                                                          : null,
                                                      size: 35.0,
                                                    ),
                                                  ),
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
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  alignment:
                                                      Alignment.centerLeft,
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
                        )
                      else
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 460.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: listOfNearbyPlaces!
                                .map(
                                  (e) => SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        100.0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            showSpinner = true;
                                          });

                                          await getDataMeteo(e);
                                          if (!mounted) return;
                                          await Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PlaceView(
                                              placeInfo: e,
                                              weather: weather,
                                            );
                                          }));
                                          setState(() {
                                            listOfNearbyPlaces =
                                                listOfNearbyPlaces;
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
                                                      '${e.price} ${AppLocalizations.of(context)!.pricing}'),
                                                  trailing: GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        showSpinner = true;
                                                      });
                                                      await LikedPlaceAPi()
                                                          .modifyLikedPlaceState(
                                                              e);
                                                      setState(() {
                                                        if (e.liked == true) {}
                                                        showSpinner = false;
                                                      });
                                                    },
                                                    child: Icon(
                                                      (e.liked == true)
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: (e.liked == true)
                                                          ? Colors.red
                                                          : null,
                                                      size: 35.0,
                                                    ),
                                                  ),
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
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  alignment:
                                                      Alignment.centerLeft,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 50.0),
                          child: Text(
                            AppLocalizations.of(context)!.popularPlaces,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
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
                                  if (!mounted) return;
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PlaceView(
                                      placeInfo: e,
                                      weather: weather,
                                    );
                                  }));
                                  setState(() {
                                    listOfPlaces = listOfPlaces;
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
                                          trailing: GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                showSpinner = true;
                                              });
                                              await LikedPlaceAPi()
                                                  .modifyLikedPlaceState(e);
                                              setState(() {
                                                if (e.liked == true) {}
                                                showSpinner = false;
                                              });
                                            },
                                            child: Icon(
                                              (e.liked == true)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: (e.liked == true)
                                                  ? Colors.red
                                                  : null,
                                              size: 35.0,
                                            ),
                                          ),
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
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          border: const OutlineInputBorder(
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
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 8.0),
                          child: Material(
                            elevation: 5.0,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                    builder: (context) => const MakeTrip(),
                                  ),
                                );
                              },
                              minWidth: 150.0,
                              height: 50.0,
                              child: Text(
                                AppLocalizations.of(context)!.makeTrip,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 8.0),
                          child: Material(
                            elevation: 5.0,
                            //color: Colors.indigo[300],
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, WelcomeScreen.id);
                              },
                              minWidth: 150.0,
                              height: 50.0,
                              child: Text(
                                AppLocalizations.of(context)!.explore,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (listOfNearbyPlaces!.isNotEmpty)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 50.0),
                            child: Text(
                              AppLocalizations.of(context)!.nearbyPlaces,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (listOfNearbyPlaces!.isNotEmpty)
                      if (listOfNearbyPlaces!.length == 1)
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 460.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: listOfNearbyPlaces!
                                .map(
                                  (e) => SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        30.0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            showSpinner = true;
                                          });

                                          await getDataMeteo(e);
                                          if (!mounted) return;
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PlaceView(
                                              placeInfo: e,
                                              weather: weather,
                                            );
                                          }));
                                          setState(() {
                                            listOfNearbyPlaces =
                                                listOfNearbyPlaces;
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
                                                      '${e.price} ${AppLocalizations.of(context)!.pricing}'),
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
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  alignment:
                                                      Alignment.centerLeft,
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
                        )
                      else
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50.0,
                          height: 460.0,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: listOfNearbyPlaces!
                                .map(
                                  (e) => SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        100.0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            showSpinner = true;
                                          });

                                          await getDataMeteo(e);
                                          if (!mounted) return;
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PlaceView(
                                              placeInfo: e,
                                              weather: weather,
                                            );
                                          }));
                                          setState(() {
                                            listOfNearbyPlaces =
                                                listOfNearbyPlaces;
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
                                                      '${e.price} ${AppLocalizations.of(context)!.pricing}'),
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
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  alignment:
                                                      Alignment.centerLeft,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 50.0),
                          child: Text(
                            AppLocalizations.of(context)!.popularPlaces,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
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
                                  if (!mounted) return;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PlaceView(
                                      placeInfo: e,
                                      weather: weather,
                                    );
                                  }));
                                  setState(() {
                                    listOfPlaces = listOfPlaces;
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

class MainScreenEmptyPlaces extends StatelessWidget {
  const MainScreenEmptyPlaces({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              AppLocalizations.of(context)!.noPlacesFound,
              style: const TextStyle(
                fontSize: 35.0,
                color: Colors.black,
              ),
            ),
          ),
        )),
      ),
    );
  }
}
