import 'package:flutter/material.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/gallery.dart';

class PlaceView extends StatefulWidget {
  const PlaceView({Key? key}) : super(key: key);
  static const String id = 'place_view';

  @override
  State<PlaceView> createState() => _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('images/grande.jpg'),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5.0,
                      color: const Color(0xFF3F51B5),
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 150.0,
                        height: 42.0,
                        child: const Text(
                          'Visit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5.0,
                      color: const Color(0xFF3F51B5),
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Gallery.id);
                        },
                        minWidth: 150.0,
                        height: 42.0,
                        child: const Text(
                          'Gallery',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
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
                child: ListTile(
                  title: const Text(
                    'Mansorah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.surround_sound_outlined,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: kText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
