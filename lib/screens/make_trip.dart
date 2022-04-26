import 'package:flutter/material.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/path_screen.dart';

class MakeTrip extends StatefulWidget {
  const MakeTrip({Key? key}) : super(key: key);
  static const String id = 'mak_trip';

  @override
  State<MakeTrip> createState() => _MakeTripState();
}

class _MakeTripState extends State<MakeTrip> {
  bool monument = false;
  bool mosque = false;
  bool museum = false;
  bool rural = false;
  bool stadium = false;
  bool park = false;
  Color colorMonument = kColorNotSelected;
  Color colorMosque = kColorNotSelected;
  Color colorMuseum = kColorNotSelected;
  Color colorRural = kColorNotSelected;
  Color colorStadium = kColorNotSelected;
  Color colorPark = kColorNotSelected;

  bool isChecked = false;

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                            monument = true;
                          } else {
                            colorMonument = kColorNotSelected;
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Monuments',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
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
                            mosque = true;
                          } else {
                            colorMosque = kColorNotSelected;
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Mosques',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
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
                            museum = true;
                          } else {
                            colorMuseum = kColorNotSelected;
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Museum',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
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
                          if (rural == false) {
                            colorRural = kColorSelected;
                            rural = true;
                          } else {
                            colorRural = kColorNotSelected;
                            rural = false;
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25.0),
                        decoration: BoxDecoration(
                          color: colorRural,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Rural Places',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
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
                          if (stadium == false) {
                            colorStadium = kColorSelected;
                            stadium = true;
                          } else {
                            colorStadium = kColorNotSelected;
                            stadium = false;
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25.0),
                        decoration: BoxDecoration(
                          color: colorStadium,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Stadiums',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
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
                            park = true;
                          } else {
                            colorPark = kColorNotSelected;
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Parks',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
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
              Card(
                color: Colors.grey[50],
                elevation: 0,
                child: ListTile(
                  title: const Text(
                    'Free to visit: ',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  trailing: getCheckBox(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Card(
                color: Colors.grey[50],
                elevation: 0,
                child: ListTile(
                  leading: const Text(
                    'Not Further than: ',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  title: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        )),
                  ),
                  trailing: const Text(
                    'Km',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
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
                    onPressed: () {
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
    );
  }
}
