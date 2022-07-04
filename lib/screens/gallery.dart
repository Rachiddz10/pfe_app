import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
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
        listVideoController.add(VideoPlayerController.network(videoURLs!.last)
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize());
        listChewController.add(
          ChewieController(
            videoPlayerController: VideoPlayerController.network(videoURLs!.last),
            aspectRatio: listVideoController.last.value.aspectRatio,
            looping: true,
            autoInitialize: true,

          ),
        );
        bool muted = (listVideoController.last.value.volume == 0);
        listMuted.add(muted);
      } else {
        soundURLs!.add('$kURlForImage${e.uri}');
      }
    }
  }

  //---------------------------------

  //--------- video play ------------

  List<VideoPlayerController> listVideoController = [];
  List<ChewieController> listChewController = [];
  List<bool> listMuted = [];

  @override
  void dispose() {

     for (var e in listChewController) {
      e.pause();
    }

    super.dispose();
  }

  //---------------------------------

  @override
  initState() {
    listOfMedia = widget.listGallery;
    initImage();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imageUrl in imageURLs!) {
        precacheImage(NetworkImage(imageUrl), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        for (var e in listChewController) {
          e.pause();
          e.dispose();
        }

        for (var e in listVideoController) {
          e.pause();
          e.dispose();
        }
        return true;
      },
      child: Scaffold(
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
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
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
                                ),
                              ),
                            ],
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
                          enableInfiniteScroll: false,
                          height: 450.0,
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
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  height: 300.0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    child: SizedBox(
                                      width: 1000.0,
                                      height: 300.0,
                                      child: Chewie(
                                        controller: listChewController[indexSecond],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
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
                  /*Container(
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
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
