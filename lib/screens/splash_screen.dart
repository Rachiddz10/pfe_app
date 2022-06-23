import 'package:flutter/material.dart';
import 'package:pfe_app/apis/places_api.dart';
import 'package:pfe_app/components/user.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/main_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:async';
import '../apis/places_info_api.dart';
import '../components/nearby_place_info.dart';
import '../components/place.dart';
import '../components/place_id.dart';
import '../components/place_structure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    this.idNumber,
    this.name,
    this.image,
    this.nearbyPlaces,
    Key? key,
  }) : super(key: key);
  static const String id = 'splash_screen';
  final int? idNumber;
  final String? name;
  final String? image;
  final List<NearbyPlaceInfo>? nearbyPlaces;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //------- City api (id + name) ------
  int? id;
  String? name;
  String? image;

  void initializeData() {
    id = widget.idNumber;
    name = widget.name;
    image = widget.image;
  }

  //------------ Place Api -----------

  //-----------------------------------

  dynamic json;
  List<PlaceStructure> listPlaceInfo = [];
  List<PlaceCard> listPlaceCard = [];

  Future<void> getPlacesApi(int id) async {
    listPlaceCard = [];
    List<Place> listOfPlacesId = await PlacesApi().fetchAll(id);
    for (int i = 0; i < listOfPlacesId.length; i++) {
      listPlaceCard.add(PlaceCard(id: listOfPlacesId[i].id));
    }
  }

  Future<List<PlaceStructure>> getPlacesInfo(int id) async {
    listPlaceInfo = [];
    for (int j = 0; j < listPlaceCard.length; j++) {
      List<PlaceStructure> listOfPlaces =
          await PlaceInfo().fetchAll(id, listPlaceCard[j].id!);
      for (int i = 0; i < listOfPlaces.length; i++) {
        listPlaceInfo.add(
          PlaceStructure(
            idPlace: listOfPlaces[i].idPlace,
            name: listOfPlaces[i].name,
            description: listOfPlaces[i].description,
            thumb: listOfPlaces[i].thumb,
            price: listOfPlaces[i].price,
            time: listOfPlaces[i].time,
            lat: listOfPlaces[i].lat,
            long: listOfPlaces[i].long,
            summary: listOfPlaces[i].summary,
            liked: listOfPlaces[i].liked,
          ),
        );
      }
    }
    return listPlaceInfo;
  }

  //-----------------------------------

  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: Colors.red,
          backgroundColor: Colors.white,
        ),
        //color: Colors.white,
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$kURlForImage$image'),
                colorFilter: ColorFilter.mode(
                    Colors.green.withOpacity(0.2), BlendMode.saturation),
                fit: BoxFit.cover,
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SizedBox(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  '$name',
                                  textStyle: const TextStyle(
                                    fontSize: 45.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.end,
                                  speed: const Duration(milliseconds: 250),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 30.0),
                          child: SizedBox(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText(
                                  User.first != ''
                                      ? 'Welcome ${User.first}'
                                      : 'welcomes you',
                                  textStyle: const TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              isRepeatingAnimation: true,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 100.0, top: 50.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              elevation: 5.0,
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                              child: MaterialButton(
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  /*LocationGetter location = LocationGetter();
                                  await location.getCurrentLocation();
                                  List<Place> nearbyPlaces = await NearbyPlacesAPI().fetchNearbyPlaces(location.long!, location.lat!, id!, 80);*/
                                  await getPlacesApi(id!);
                                  listPlaceInfo = await getPlacesInfo(id!);
                                  List<PlaceStructure> listOfNearbyPlaces = [];
                                  List<int> idsNearbyPlaces = [];
                                  for(var e in widget.nearbyPlaces!) {
                                    idsNearbyPlaces.add(e.id);
                                  }
                                  for(var e in listPlaceInfo) {
                                    if(idsNearbyPlaces.contains(e.idPlace)) {
                                      listOfNearbyPlaces.add(e);
                                    }
                                  }
                                  if (!mounted) return;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MainScreen(
                                      idNumber: id,
                                      list: listPlaceCard,
                                      listOfPlaces: listPlaceInfo,
                                      nearbyPlaces: listOfNearbyPlaces,
                                      idsNearbyPlaces: widget.nearbyPlaces,
                                    );
                                  }));
                                  Future.delayed(const Duration(seconds: 3));
                                  setState(() {
                                    showSpinner = false;
                                  });
                                },
                                minWidth: 150.0,
                                height: 42.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.visitThisTown,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
