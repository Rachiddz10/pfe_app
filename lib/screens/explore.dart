import 'package:flutter/material.dart';


class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);
  static const String id = 'explore';

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  @override
  Widget build(BuildContext context) {
    return const Text('hello');
  }

  /*List<Widget> list = getListChild();

  List<Widget> modifyListChild() {
    list.add(
      Flexible(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlaceView.id);
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.arrow_right,
                  //size: 40.0,
                ),
                SizedBox(
                  //height: 10.0,
                ),
                Text(
                  'See More',
                  style: TextStyle(
                    //fontSize: 18.0,
                  ),
                ),
              ],
            ),
            //margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: kColorNotSelected,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    list = modifyListChild();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                  bottom: 25.0,
                ),
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
                  'Most Viewed',
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
                  'Beauty of nature',
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
                  'Best rating restaurants',
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
                  children: list,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
