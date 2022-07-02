import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pfe_app/apis/make_trip_api.dart';
import 'package:pfe_app/components/category_place.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/core/geo_location.dart';
import 'package:pfe_app/screens/path_screen.dart';

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
                    height: 10.0,
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

                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
                    child: CupertinoFormSection(
                      header: const Text('Circuit Criteria'),
                      children: [
                        CupertinoFormRow(
                          prefix: const Text('Price'),
                          helper: const Text(
                            '-1 for unlimited budget',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          //error: const Text(''),
                          child: CupertinoTextFormFieldRow(
                            placeholder: '1000 DZD',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: const Text('Time'),
                          helper: const Text(
                            '0 for unlimited time',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            placeholder: '60 min',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        CupertinoFormRow(
                          prefix: const Text('Distance'),
                          helper: const Text(
                            '-1 for unlimited budget',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          child: CupertinoTextFormFieldRow(
                            keyboardType: TextInputType.number,
                            placeholder: '5000 meters',
                          ),
                        ),
                      ],
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
                          setState(() {
                            showSpinner = true;
                          });
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
                          print(list);
                          if (!mounted) return;
                          Navigator.pushNamed(context, PathScreen.id);
                          setState(() {
                            showSpinner = false;
                          });
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
