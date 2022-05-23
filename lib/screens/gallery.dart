import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_app/components/gallery_class.dart';
import 'package:pfe_app/components/video_builder.dart';
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
  final CarouselController _controller = CarouselController();

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

  late VideoPlayerController controllerPlayVideo;
  bool isMuted = false;

  void initializeVideo() {
    controllerPlayVideo = VideoPlayerController.network(videoURLs![0])
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controllerPlayVideo.play());
    isMuted = (controllerPlayVideo.value.volume == 0);
  }

  @override
  void dispose() {
    controllerPlayVideo.dispose();
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
                          VideoPlayerWidget(controller: controllerPlayVideo),
                          const SizedBox(
                            height: 32.0,
                          ),
                          if (controllerPlayVideo.value.isInitialized)
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.red,
                              child: IconButton(
                                icon: Icon(
                                  isMuted
                                      ? Icons.volume_mute
                                      : Icons.volume_up,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    controllerPlayVideo.setVolume(
                                      isMuted ? 1 : 0,
                                    );
                                    if(isMuted == true) {
                                      isMuted = false;
                                    } else { 
                                      isMuted = true;
                                    }
                                  });
                                },
                              ),
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
