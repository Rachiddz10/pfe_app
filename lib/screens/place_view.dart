import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pfe_app/constants.dart';
import 'package:pfe_app/screens/gallery.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/core/geo_location.dart';
import 'package:pfe_app/screens/place_map.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  'https://media-cdn.tripadvisor.com/media/photo-s/08/56/c2/26/great-mosque-or-tlemcen.jpg',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.only(top: 20.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
            ],
          )),
    ))
    .toList();


const apiKeyWeather = Text('a1173da81b738a5fdc4ad146f555d9ab');

const apiKeyGoogleNotRestricted = Text('AIzaSyAFvqUhsOngyoyEokDFiN84WO-4MwWKpmo');
const apiKeyGoogle = Text('AIzaSyBAGR7tefhwB4thG7lXUskeyfHfa2avcUI');


class PlaceView extends StatefulWidget {
  const PlaceView({Key? key}) : super(key: key);
  static const String id = 'place_view';

  @override
  State<PlaceView> createState() => _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {

  //------------- Text to speech -------
  FlutterTts? _flutterTts;
  String? description = kText.data;
  bool isPlaying = false;


  //-----------------------------------
  double? temperature;
  int? temp;
  String? weatherDescription;
  String? iconURL;

  Location location = Location();

  Future getDataMeteo() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=34.8562728&lon=-1.7312301&appid=a1173da81b738a5fdc4ad146f555d9ab&units=metric'));
    if (response.statusCode == 200) {
      String data = response.body;
      temperature = jsonDecode(data)['main']['temp'];
      temp = temperature!.toInt();
      weatherDescription = jsonDecode(data)['weather'][0]['description'];
      var condition = jsonDecode(data)['weather'][0]['icon'];
      iconURL = 'http://openweathermap.org/img/wn/$condition@2x.png';
      return temp;
    } else {
      throw Exception('Failed to load');
    }
  }

  void getLocation() async {
    await location.getCurrentLocation();
    //print('latitude = ${location.lat}\nlongitude = ${location.long}');
  }



  @override
  void initState() {
    super.initState();
    initializeTts();
    getLocation();
    getDataMeteo();
  }

  /*Future _getDefaultEngine() async {
    var engine = await _flutterTts!.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }*/

  Future _speak(String text) async {
    if (text.isNotEmpty) {
      var result = await _flutterTts!.speak(text);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

  Future _stop() async {
    var result = await _flutterTts!.stop();
    if (result == 1) {
      setState(() {
        isPlaying = false;
      });
    }
  }

  initializeTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts!.setLanguage("en-US");

    /*if (Platform.isAndroid) {
      _getDefaultEngine();
    }*/

    _flutterTts!.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    _flutterTts!.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts!.setCancelHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts!.setErrorHandler((err) {
      setState(() {
        print("error occurred: $err");
        isPlaying = false;
      });
    });

    _flutterTts!.setPauseHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts!.setContinueHandler(() {
      setState(() {
        isPlaying = true;
      });
    });
  }

  Future<void> refresh() async {
    Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    Navigator.pushNamed(context, PlaceView.id);
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void dispose() {
    super.dispose();
    _flutterTts!.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
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
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            margin: const EdgeInsets.only(left: 30.0, top: 20.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ),
                          ),
                          title: Container(
                            margin: const EdgeInsets.only(top: 20.0, right: 30.0),
                            child: const Text(
                              'Mansourah',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              Alert(
                                  context: context,
                                  title: "Weather",
                                  content: Column(
                                    children: [
                                      ListTile(
                                        title: const Text('Icon'),
                                        trailing: Image.network(iconURL!),
                                      ),
                                      ListTile(
                                        title: const Text('Temperature'),
                                        trailing: Text('$temp°'),
                                      ),
                                      ListTile(
                                        title: const Text('Description'),
                                        trailing: Text('$weatherDescription'),
                                      ),
                                    ],
                                  ),
                                  buttons: [
                                    DialogButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "Close",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300],
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Image.asset(
                                'images/img.png',
                                colorBlendMode: BlendMode.color,
                                fit: BoxFit.cover,
                                width: 80.0,
                                height: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CarouselSlider(
                          items: imageSliders,
                          carouselController: _controller,
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  (Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                        child: Material(
                          elevation: 5.0,
                          //color: const Color(0xFF3F51B5),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return PlaceMap(location: location);
                              }));
                            },
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
                        padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                        child: Material(
                          elevation: 5.0,
                          color: const Color(0xFF3F51B5),
                          borderRadius: BorderRadius.circular(15.0),
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Card(
                      color: const Color(0xFFEEB5C9),
                      child: ListTile(
                        leading: const Text(
                          'Press on the icon to Play/Stop',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //title: Text(temp!.toString()),
                        trailing: IconButton(
                          icon: isPlaying ? const Icon(
                            Icons.stop_circle_outlined,
                            color: Colors.black,
                          ) :
                          const Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.green,
                        ),
                          onPressed: () {
                            isPlaying ? _stop() : _speak(description!);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: kText,
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

  void setTtsLanguage() async {
    await _flutterTts!.setLanguage("en-US");
  }
}
