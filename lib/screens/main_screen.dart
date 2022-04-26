import 'package:flutter/material.dart';
import 'package:pfe_app/screens/make_trip.dart';
import 'package:pfe_app/screens/explore.dart';
import 'package:pfe_app/components/get_list_child.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: TextField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  hintText: 'Search',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MakeTrip.id);
                      },
                      minWidth: 150.0,
                      height: 42.0,
                      child: const Text(
                        'Make Trip',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Explore.id);
                      },
                      minWidth: 150.0,
                      height: 42.0,
                      child: const Text(
                        'Explore',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                'Nearby Places',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 23.0,
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getListChild(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                'Popular Places',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 23.0,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: getListChild(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}