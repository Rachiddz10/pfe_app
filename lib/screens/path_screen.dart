import 'package:flutter/material.dart';

class PathScreen extends StatefulWidget {
  const PathScreen({this.listOfPlaces, Key? key}) : super(key: key);
  static const String id = 'path_screen';
  final List? listOfPlaces;

  @override
  State<PathScreen> createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {
  List places = [];

  @override
  initState() {
    super.initState();
    places = widget.listOfPlaces!;
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
            child: places.length == 2
                ? const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
                    child: Card(
                      child: Card(
                        child: Center(
                          child: Text(
                            'No Places available according to the values inserted',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 5)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<CircuitPlaces> list = [];
                        return Column(
                          children: [
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25.0, horizontal: 50.0),
                                  child: Text(
                                    ' Circuit',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 23.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text('$places'),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 25.0, horizontal: 50.0),
                                  child: Text(
                                    ' Circuit',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 23.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 200.0, left: 60.0, right: 60.0),
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class CircuitPlaces {
  int? id;
  String? name;
  String? summary;
  int? distance;

  CircuitPlaces(this.id, this.name, this.summary, this.distance);
}
