import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pfe_app/apis/nearby_places_api.dart';
import 'package:pfe_app/components/nearby_place_info.dart';
import 'package:pfe_app/components/user.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/core/geo_location.dart';
import 'package:pfe_app/screens/splash_screen.dart';
import '../components/my_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CityScreen extends StatefulWidget {
  static const String id = 'city_screen';
  final List<MyCard>? list;

  const CityScreen({this.list, Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<MyCard> myCard = [];

  Future<bool?> showWarning(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
                'Going back will automatically sign you out.\nAre you sure?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    myCard = widget.list!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (User.first == '') {
          return true;
        }
        bool? shouldPop = await showWarning(context);
        if(shouldPop! == true) {
          User.logoutUser();
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            AppLocalizations.of(context)!.travel,
          ),
          centerTitle: true,
        ),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.chooseTheCity,
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: GridView.count(
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        crossAxisCount: 2,
                        children: myCard
                            .map(
                              (e) => GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  LocationGetter locationGetter = LocationGetter();
                                  await locationGetter.getCurrentLocation();
                                  List<NearbyPlaceInfo> nearbyPlaces = await NearbyPlacesAPI().fetchNearbyPlaces(locationGetter.long!, locationGetter.lat!, e.id!, 35.9);
                                  if(!mounted) return;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SplashScreen(
                                      idNumber: e.id!,
                                      name: e.title!,
                                      image: e.image!,
                                      nearbyPlaces: nearbyPlaces,
                                    );
                                  }));
                                  setState(() {
                                    showSpinner = false;
                                  });
                                },
                                child: Card(
                                  semanticContainer: true,
                                  elevation: 2.5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  //margin: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 300.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                '$kURlForImage${e.image}'))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            e.title!,
                                            style: const TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network('$kURlForImage${e.image}', fit: BoxFit.fill),
                                      Text(
                                        e.title,
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),*/
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
          ),
        ),
      ),
    );
  }
}
