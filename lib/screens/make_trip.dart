import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pfe_app/apis/make_trip_api.dart';
import 'package:pfe_app/components/category_place.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/core/geo_location.dart';
import 'package:pfe_app/screens/path_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MakeTrip extends StatefulWidget {
  const MakeTrip({this.name, this.idNumber, this.listOfCategories, Key? key})
      : super(key: key);
  static const String id = 'mak_trip';
  final String? name;
  final int? idNumber;
  final List<CategoryPlace>? listOfCategories;

  @override
  State<MakeTrip> createState() => _MakeTripState();
}

class _MakeTripState extends State<MakeTrip> {
  List<CategoryPlace> listOfCategories = [];
  int? idCity;
  String? cityName;
  List<int> idCategorySelected = [];
  bool showSpinner = false;
  bool priceChecked = true;
  bool timeChecked = true;
  bool distanceChecked = true;
  String priceText = '';
  String timeText = '';
  String distanceText = '';

  final _formKeyKey = GlobalKey<FormState>();

  @override
  void initState() {
    listOfCategories = widget.listOfCategories!;
    idCity = widget.idNumber!;
    super.initState();
  }

  List<Widget> getCategories() {
    List<Widget> listOfRows = [];
    for (var e in listOfCategories) {
      listOfRows.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (idCategorySelected.contains(e.id)) {
                idCategorySelected.remove(e.id);
              } else {
                idCategorySelected.add(e.id!);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
            margin:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            decoration: BoxDecoration(
              color: !idCategorySelected.contains(e.id)
                  ? kColorNotSelected
                  : kColorSelected,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${e.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: !idCategorySelected.contains(e.id)
                      ? kTextColorNotSelected
                      : kTextColorSelected,
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (listOfCategories.length % 2 != 0) {
      listOfRows.removeLast();
      listOfRows.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (idCategorySelected.contains(listOfCategories.last.id)) {
                idCategorySelected.remove(listOfCategories.last.id);
              } else {
                idCategorySelected.add(listOfCategories.last.id!);
              }
            });
          },
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              decoration: BoxDecoration(
                color: !idCategorySelected.contains(listOfCategories.last.id)
                    ? kColorNotSelected
                    : kColorSelected,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${listOfCategories.last.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color:
                        !idCategorySelected.contains(listOfCategories.last.id)
                            ? kTextColorNotSelected
                            : kTextColorSelected,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return listOfRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.red,
          backgroundColor: Colors.white,
        ),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 25.0,
                    ),
                    child: Text(
                      'What are you looking for?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 5,
                    runSpacing: 10,
                    children: getCategories(),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
                    child: Form(
                      key: _formKeyKey,
                      child: CupertinoFormSection(
                        header: const Text('Circuit Criteria'),
                        children: [
                          CheckboxListTile(
                            title: const Text('Unlimited Price'),
                            value: priceChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                priceChecked = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: !priceChecked,
                            child: CupertinoFormRow(
                              prefix: const Text('Price'),
                              //error: const Text(''),
                              child: CupertinoTextFormFieldRow(
                                placeholder: '1000 DZD',
                                keyboardType: TextInputType.number,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Numbers are accepted only';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  priceText = value!;
                                },
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            title: const Text('Limited time'),
                            value: timeChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                timeChecked = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: !timeChecked,
                            child: CupertinoFormRow(
                              prefix: const Text('Time'),
                              child: CupertinoTextFormFieldRow(
                                placeholder: '60 min',
                                keyboardType: TextInputType.number,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Numbers are accepted only';
                                  }
                                  if (value == '0') {
                                    return 'Time must not be equal to 0';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  timeText = value!;
                                },
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            title: const Text('Limited distance'),
                            value: distanceChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                distanceChecked = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: !distanceChecked,
                            child: CupertinoFormRow(
                              prefix: const Text('Distance'),
                              child: CupertinoTextFormFieldRow(
                                keyboardType: TextInputType.number,
                                placeholder: '5000 meters',
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Numbers are accepted only';
                                  }
                                  if (value == '0') {
                                    return 'distance must not be equal to 0';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  distanceText = value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 20.0,
                    ),
                    child: Material(
                      elevation: 5.0,
                      color: const Color(0xFF536DFE),
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () async {
                          if (!_formKeyKey.currentState!.validate()) {
                            return;
                          }
                          _formKeyKey.currentState!.save();
                          int price = -2;
                          int time = -1;
                          int distance = -1;
                          if (!priceChecked) {
                            price = int.parse(priceText);
                          }
                          if (!timeChecked) {
                            time = int.parse(timeText);
                          }
                          if (!distanceChecked) {
                            distance = int.parse(distanceText);
                          }
                          if (idCategorySelected.isEmpty) {
                            Alert(
                                context: context,
                                title: 'Please select one category at least!',
                                buttons: [
                                  DialogButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      // ignore: use_build_context_synchronously
                                      AppLocalizations.of(context)!.close,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ]).show();
                          } else {
                            setState(() {
                              showSpinner = true;
                            });
                            LocationGetter location = LocationGetter();
                            await location.getCurrentLocation();
                            List list = await MakeTripAPI().makeVoyage(
                                1,
                                location.lat!,
                                location.long!,
                                idCategorySelected,
                                time,
                                price,
                                distance);
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PathScreen(
                                  listOfPlaces: list,
                                ),
                              ),
                            );
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        },
                        minWidth: 250.0,
                        height: 42.0,
                        child: const Text(
                          'Find places',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.0,
                          ),
                        ),
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
