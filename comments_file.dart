/* this file contain comments of code that may be needed during the realization of this projetc*/

/*GestureDetector buildCard() {
    var ran = Random();
    var heading = '\$${(ran.nextInt(20) + 15).toString()}00 per month';
    var subheading =
        '${(ran.nextInt(3) + 1).toString()} bed, ${(ran.nextInt(2) + 1).toString()} bath, ${(ran.nextInt(10) + 7).toString()}00 sqft';
    var cardImage = NetworkImage(
        'https://source.unsplash.com/random/800x600?house&${ran.nextInt(100).toString()}');
    var supportingText =
        'Beautiful home to rent, recently refurbished with modern appliances...';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PlaceView.id);
      },
      child: Card(
        child: Card(
            elevation: 4.0,
            child: Column(
              children: [
                ListTile(
                  title: Text(heading),
                  subtitle: Text(subheading),
                  trailing: const Icon(Icons.favorite_outline),
                ),
                SizedBox(
                  height: 200.0,
                  child: Ink.image(
                    image: cardImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(supportingText),
                ),
                /*ButtonBar(
                  children: [
                    TextButton(
                      child: const Text('CONTACT AGENT'),
                      onPressed: () {
                        *//* ... *//*
                      },
                    ),
                    TextButton(
                      child: const Text('LEARN MORE'),
                      onPressed: () {
                        *//* ... *//*
                      },
                    )
                  ],
                )*/
              ],
            )),
      ),
    );
  }
  */


/*
//------------- Card Builder Vertical
  List<Widget> buildVerticalCard() {
    List<Widget> listHorizontal = [];
    for (var element in listOfPlaces!) {
      var heading = '${element.name}';
      var subheading = '${element.price} DZD for entry';
      var cardImage = NetworkImage('$kURlForImage/${element.thumb}');
      var supportingText = '${element.summary}';
      listHorizontal.add(
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width - 100.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PlaceView.id);
              },
              child: Card(
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(heading),
                        subtitle: Text(subheading),
                        trailing: const Icon(Icons.favorite_outline),
                      ),
                      SizedBox(
                        height: 200.0,
                        child: Ink.image(
                          image: cardImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        child: Text(supportingText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return listHorizontal;
  }
 */

/*
//------ PLace Thumb API
import 'dart:convert';
import '../components/place_thumb.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_app/constants.dart';

class PlacesThumbs {

  Future<List<PlaceThumb>> fetchAll(int id, int idNumber) async {
    List<PlaceThumb> listPlacesThumb = [];
    final http.Response response = await http.get(Uri.parse('$kURl/$id/$idNumber/thumb'));
    final http.Response responseMeta = await http.get(Uri.parse('$kURl/$id/$idNumber/meta'));
    var json = jsonDecode(response.body);
    var jsonMeta = jsonDecode(responseMeta.body);
    if (response.statusCode == 200 && responseMeta.statusCode == 200) {
      listPlacesThumb.add(PlaceThumb.fromJson(json, jsonMeta));
      return listPlacesThumb;
    } else {
      throw Exception(' Failed to load Places');
    }
  }
}*/


/*
//------ PLace Thumb
class PlaceThumb {
  final String? name;
  final String? summary;
  final String? thumb;
  final int? price;
  final int? time;

  PlaceThumb({required this.name, required this.summary, required this.thumb, required this.price, required this.time});

  factory PlaceThumb.fromJson(Map<String, dynamic> json, List<dynamic> jsonMeta) {
    PlaceThumb place = PlaceThumb(
      name: json['name'],
      summary: json['summary'],
      thumb: json['thumb'],
      price: jsonMeta[0]['price'],
      time: jsonMeta[0]['time'],
    );
    return place;
  }
}*/


//----------  image urls  -------------------
/*

//List<String>? images;
images = [
      'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
      'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
      'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
      'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
      'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
      'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
      'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    ];
 */

/* ------------------- needed for play video
SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 500.0,
                  child: ((videoURLs!.isNotEmpty) == true)
                      ? Column(
                          children: [
                            FutureBuilder(
                              future: _initializeVideoPlayerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Center(
                                    child: AspectRatio(
                                      aspectRatio: _controllerPlayVideo
                                          .value.aspectRatio,
                                      child: VideoPlayer(_controllerPlayVideo),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (_controllerPlayVideo.value.isPlaying) {
                                    _controllerPlayVideo.pause();
                                  } else {
                                    _controllerPlayVideo.play();
                                  }
                                });
                              },
                              child: Icon(
                                _controllerPlayVideo.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 38.0),
                          child: Card(
                            color: Colors.indigo[300],
                            child: Card(
                              color: const Color(0xFFE0D7DC),
                              elevation: 5.0,
                              child: Center(
                                child: Container(
                                  color: const Color(0xFFE0D7DC),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    'No Video inserted for this place',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.indigo[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
 */

/* ----- 2 Video Player
SizedBox(
                  child: ((videoURLs!.isNotEmpty) == true)
                      ? Column(
                        children: [
                          FutureBuilder(
                              future: _initializeVideoPlayerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 20,
                                      height: 300.0,
                                      child: AspectRatio(
                                        aspectRatio:
                                            _controllerPlayVideo.value.aspectRatio,
                                        child: VideoPlayer(_controllerPlayVideo),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (_controllerPlayVideo.value.isPlaying) {
                                  _controllerPlayVideo.pause();
                                } else {
                                  _controllerPlayVideo.play();
                                }
                              });
                            },
                            child: Icon(
                              _controllerPlayVideo.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          )
                        ],
                      )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 38.0),
                          child: Card(
                            color: Colors.indigo[300],
                            child: Card(
                              color: const Color(0xFFE0D7DC),
                              elevation: 5.0,
                              child: Center(
                                child: Container(
                                  color: const Color(0xFFE0D7DC),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    'No Video inserted for this place',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.indigo[300],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
 */

/* ---------- 3 video player -------------------
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_app/components/gallery_class.dart';
import 'package:pfe_app/constants.dart';
import 'package:video_player/video_player.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key, this.listGallery}) : super(key: key);
  static const String id = 'gallery';
  final List<GalleryClass>? listGallery;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  //-------- Gallery API -------

  List<GalleryClass>? listOfMedia;

  //-----------------------------

  //------ split (images, videos, sounds) ----

  int _current = 0;
  int _currentVideo = 0;
  final CarouselController _controller = CarouselController();
  final CarouselController _controllerVideo = CarouselController();

  List<String>? imageURLs = [];
  List<String>? videoURLs = [];
  List<String>? soundURLs = [];

  void initImage() {
    for (var e in listOfMedia!) {
      if (e.type!.contains('image')) {
        imageURLs!.add('$kURlForImage${e.uri}');
      } else if (e.type!.contains('video')) {
        videoURLs!.add('$kURlForImage${e.uri}');
      } else {
        soundURLs!.add('$kURlForImage${e.uri}');
      }
    }
    /*imageURLs!.add('https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80');
    imageURLs!.add('https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80');
    imageURLs!.add('https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80');
    imageURLs!.add('https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80');
    imageURLs!.add('https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80');*/
  }

  //---------------------------------

  //--------- video play ------------

  late VideoPlayerController _controllerPlayVideo;
  late Future<void> _initializeVideoPlayerFuture;

  void initializeVideo() {
    _controllerPlayVideo = VideoPlayerController.network(videoURLs![0])
    ..addListener(() => setState(() {}));
    _initializeVideoPlayerFuture = _controllerPlayVideo.initialize();
    _controllerPlayVideo.setLooping(true);
    _controllerPlayVideo.play();
  }

  @override
  void dispose() {
    _controllerPlayVideo.dispose();
    super.dispose();
  }

  //---------------------------------

  @override
  initState() {
    listOfMedia = widget.listGallery;
    initImage();
    super.initState();
    initializeVideo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imageUrl in imageURLs!) {
        precacheImage(NetworkImage(imageUrl), context);
      }
    });
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(
                      top: 30.0, left: 80.0, right: 80.0, bottom: 20.0),
                  height: 50.0,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.galleryPhotos,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'PermanentMarker',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: ((imageURLs!.isNotEmpty) == true)
                      ? [
                          CarouselSlider.builder(
                            itemCount: imageURLs!.length,
                            carouselController: _controller,
                            options: CarouselOptions(
                              height: 300.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                            itemBuilder: (context, indexSecond, realIdx) {
                              return Container(
                                margin: const EdgeInsets.all(5.0),
                                height: 300.0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  child: Image.network(
                                    imageURLs![indexSecond],
                                    fit: BoxFit.cover,
                                    width: 1000.0,
                                    height: 300.0,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imageURLs!.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(_current == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ]
                      : [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 38.0),
                            child: Card(
                              color: Colors.indigo[300],
                              child: Card(
                                color: const Color(0xFFE0D7DC),
                                elevation: 5.0,
                                child: Center(
                                  child: Container(
                                    color: const Color(0xFFE0D7DC),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      'No Image inserted for this place',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.indigo[300],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(
                      top: 30.0, left: 80.0, right: 80.0, bottom: 20.0),
                  height: 50.0,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.galleryVideos,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'PermanentMarker',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: ((videoURLs!.isNotEmpty) == true)
                      ? [
                          CarouselSlider.builder(
                            itemCount: videoURLs!.length,
                            carouselController: _controllerVideo,
                            options: CarouselOptions(
                              height: 400.0,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentVideo = index;
                                });
                              },
                            ),
                            itemBuilder: (context, indexSecond, realIdx) {
                              return Column(
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_controllerPlayVideo
                                            .value.isPlaying) {
                                          _controllerPlayVideo.pause();
                                        } else {
                                          _controllerPlayVideo.play();
                                        }
                                      });
                                    },
                                    child: Icon(
                                      _controllerPlayVideo.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(5.0),
                                      height: 390.0,
                                      child: FutureBuilder(
                                        future: _initializeVideoPlayerFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return AspectRatio(
                                              aspectRatio: _controllerPlayVideo
                                                  .value.aspectRatio,
                                              child: VideoPlayer(
                                                  _controllerPlayVideo),
                                            );
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: videoURLs!.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controllerVideo.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(
                                              _currentVideo == entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ]
                      : [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 38.0),
                            child: Card(
                              color: Colors.indigo[300],
                              child: Card(
                                color: const Color(0xFFE0D7DC),
                                elevation: 5.0,
                                child: Center(
                                  child: Container(
                                    color: const Color(0xFFE0D7DC),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      'No Video inserted for this place',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.indigo[300],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(
                      top: 30.0, left: 80.0, right: 80.0, bottom: 20.0),
                  height: 50.0,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.gallerySounds,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'PermanentMarker',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: ((soundURLs!.isNotEmpty) == true)
                      ? [
                          CarouselSlider.builder(
                            itemCount: imageURLs!.length,
                            carouselController: _controller,
                            options: CarouselOptions(
                              height: 300.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                            itemBuilder: (context, indexSecond, realIdx) {
                              return Container(
                                margin: const EdgeInsets.all(5.0),
                                height: 300.0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  child: Image.network(
                                    imageURLs![indexSecond],
                                    fit: BoxFit.cover,
                                    width: 1000.0,
                                    height: 300.0,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imageURLs!.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(_current == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ]
                      : [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 38.0),
                            child: Card(
                              color: Colors.indigo[300],
                              child: Card(
                                color: const Color(0xFFE0D7DC),
                                elevation: 5.0,
                                child: Center(
                                  child: Container(
                                    color: const Color(0xFFE0D7DC),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      'No Sound inserted for this place',
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.indigo[300],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 */

/*Future setLandscape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Wakelock.enable();
  }

  Future setAllOrientations() async{
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await Wakelock.disable();
  }*/