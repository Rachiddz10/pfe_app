import 'package:flutter/material.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/splash_screen.dart';
import '../components/my_card.dart';

class CityScreen extends StatefulWidget {
  static const String id = 'city_screen';
  final List<MyCard>? list;

  const CityScreen({this.list, Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<MyCard> myCard = [];

  @override
  void initState() {
    super.initState();
    myCard = widget.list!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Travel'),
        centerTitle: true,
      ),
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
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(
                  'Choose the city',
                  style: TextStyle(
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
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SplashScreen(
                                  idNumber: e.id!,
                                  name: e.title!,
                                  image: e.image!,
                                );
                              }));
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
    );
  }
}
