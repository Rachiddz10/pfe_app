import 'package:flutter/material.dart';
import 'package:pfe_app/apis/make_trip_api.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/core/geo_location.dart';
import 'package:pfe_app/screens/path_screen.dart';

class MakeTrip extends StatefulWidget {
  const MakeTrip({this.name, Key? key}) : super(key: key);
  static const String id = 'mak_trip';
  final String? name;

  @override
  State<MakeTrip> createState() => _MakeTripState();
}

class _MakeTripState extends State<MakeTrip> {
  String? cityName;

  bool monument = false;
  bool mosque = false;
  bool museum = false;
  bool park = false;
  bool naturalPark = false;

  Color colorMonument = kColorNotSelected;
  Color colorMosque = kColorNotSelected;
  Color colorMuseum = kColorNotSelected;
  Color colorNaturalPark = kColorNotSelected;
  Color colorPark = kColorNotSelected;

  Color colorTextMonument = kTextColorNotSelected;
  Color colorTextMosque = kTextColorNotSelected;
  Color colorTextMuseum = kTextColorNotSelected;
  Color colorTextNaturalPark = kTextColorNotSelected;
  Color colorTextPark = kTextColorNotSelected;

  bool isChecked = false;

  final TextEditingController priceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  Checkbox getCheckBox() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return const Color(0xFF757575);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  @override
  void initState() {
    if (widget.name != null) {
      cityName = widget.name;
    }
    super.initState();
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
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (monument == false) {
                              colorMonument = kColorSelected;
                              colorTextMonument = kTextColorSelected;
                              monument = true;
                            } else {
                              colorMonument = kColorNotSelected;
                              colorTextMonument = kTextColorNotSelected;
                              monument = false;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: colorMonument,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Monuments',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: colorTextMonument,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (mosque == false) {
                              colorMosque = kColorSelected;
                              colorTextMosque = kTextColorSelected;
                              mosque = true;
                            } else {
                              colorMosque = kColorNotSelected;
                              colorTextMosque = kTextColorNotSelected;
                              mosque = false;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: colorMosque,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Mosques',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: colorTextMosque,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (museum == false) {
                              colorMuseum = kColorSelected;
                              colorTextMuseum = kTextColorSelected;
                              museum = true;
                            } else {
                              colorMuseum = kColorNotSelected;
                              colorTextMuseum = kTextColorNotSelected;
                              museum = false;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: colorMuseum,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Museum',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: colorTextMuseum,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (park == false) {
                              colorPark = kColorSelected;
                              colorTextPark = kTextColorSelected;
                              park = true;
                            } else {
                              colorPark = kColorNotSelected;
                              colorTextPark = kTextColorNotSelected;
                              park = false;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: colorPark,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Parks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: colorTextPark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (naturalPark == false) {
                              colorNaturalPark = kColorSelected;
                              colorTextNaturalPark = kTextColorSelected;
                              naturalPark = true;
                            } else {
                              colorNaturalPark = kColorNotSelected;
                              colorTextNaturalPark = kTextColorNotSelected;
                              naturalPark = false;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 25.0),
                          decoration: BoxDecoration(
                            color: colorNaturalPark,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Natural Parks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: colorTextNaturalPark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                /*Card(
                  color: Colors.grey[50],
                  elevation: 0,
                  child: Column(
                    children: [
                      /*ListTile(
                        title: const Text(
                          'Free to visit: ',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        trailing: getCheckBox(),
                      ),*/
                      ListTile(
                        title: const Text(
                          'Price:',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        trailing: TextField(
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),*/
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Card(

                    color: Colors.grey[50],
                    elevation: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Row(
                            children: [
                              const Text(
                                'Price: ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: priceController,
                                  onChanged: (value) {},
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
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
                              Container(
                                width: 90.0,
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Center(
                                  child: Text(
                                    'DZD',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Row(
                            children: [
                              const Text(
                                'Time: ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: timeController,
                                  onChanged: (value) {},
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
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
                              Container(
                                width: 90.0,
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Center(
                                  child: Text(
                                    'Minutes',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0, bottom: 8.0),
                          child: Row(
                            children: [
                              const Text(
                                'Distance: ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: distanceController,
                                  onChanged: (value) {},
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
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
                              Container(
                                width: 90.0,
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Center(
                                  child: Text(
                                    'Meters',
                                    style: TextStyle(
                                      fontSize: 20.0,
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
                ),
                const SizedBox(
                  height: 20.0,
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
                        LocationGetter location = LocationGetter();
                        await location.getCurrentLocation();
                        List list = await MakeTripAPI().makeVoyage(
                            1,
                            location.lat!,
                            location.long!,
                            ["1", "2", "4", "5", "6"],
                            0,
                            -1,
                            0);
                        if (!mounted) return;
                        Navigator.pushNamed(context, PathScreen.id);
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
    );
  }
}
