import 'package:flutter/material.dart';
import 'package:pfe_app/apis/place.dart';
import 'package:pfe_app/screens/place_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../apis/weather_api.dart';
import '../components/category_place.dart';
import '../components/place_structure.dart';
import '../components/weather.dart';
import '../constants.dart';

class Explore extends StatefulWidget {
  const Explore({this.idNumber, this.listOfCategories, Key? key})
      : super(key: key);
  static const String id = 'explore';
  final int? idNumber;
  final List<CategoryPlace>? listOfCategories;

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<CategoryPlace> listOfCategories = [];
  int? idCity;
  List<ExploreCategory> listOfPlaces = [];
  bool showSpinner = false;

  @override
  initState() {
    listOfCategories = widget.listOfCategories!;
    idCity = widget.idNumber!;
    super.initState();
  }

  Future getPlacesCategories() async {
    listOfPlaces = await PlaceCategoryAPI()
        .fetchPlaceFromCategories(idCity!, listOfCategories);
  }

  Weather? weather;

  Future getDataMeteo(PlaceStructure placeStructure) async {
    weather = await WeatherAPI().getDataMeteo(placeStructure);
  }

  List<Widget> displayData() {
    List<Widget> listUI = [];
    for (var element in listOfPlaces) {
      listUI.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 25.0, horizontal: 50.0),
            child: Text(
              '${element.categoryPlace!.name}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 23.0,
              ),
            ),
          ),
        ],
      ),);
      listUI.add(
          SizedBox(
            width: MediaQuery.of(context).size.width - 50.0,
            height: 460.0,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: element.listOfPlaces!
                  .map(
                    (e) =>
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
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
                                    child: Text(
                                        '${e.summary}'),
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
          ));
    }
    return listUI;
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                FutureBuilder(
                    future: getPlacesCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: displayData(),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.only(
                              top: 200.0, left: 60.0, right: 60.0),
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
