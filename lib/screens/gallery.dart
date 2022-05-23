import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_app/components/gallery_class.dart';

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


  List<String>? images;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  void initImage() {
    images = [
      'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
      'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
      'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
      'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
      'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
      'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
      'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    ];
  }

  @override
  initState() {
    initImage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imageUrl in images!) {
        precacheImage(NetworkImage(imageUrl), context);
      }
    });
    super.initState();
    listOfMedia = widget.listGallery;
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
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0, bottom: 20.0),
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
              CarouselSlider.builder(
                itemCount: images!.length,
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
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      child: Image.network(
                        images![indexSecond],
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
                children: images!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
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
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0, bottom: 20.0),
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(top: 30.0, left: 80.0, right: 80.0, bottom: 20.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
