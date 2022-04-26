import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);
  static const String id = 'gallery';

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> urls = [
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/74/95/cc/les-cascades-de-el-ourit.jpg?w=500&h=300&s=1',
    'https://www.tunisiepromo.com/wp-content/uploads/2018/09/Tlemcen-guide-touristique-alg%C3%A9rie0101.jpg',
    'https://journals.openedition.org/etudescaribeennes/docannexe/image/12450/img-12-small580.jpg',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/74/95/cc/les-cascades-de-el-ourit.jpg?w=500&h=300&s=1',
    'https://www.tunisiepromo.com/wp-content/uploads/2018/09/Tlemcen-guide-touristique-alg%C3%A9rie0101.jpg',
    'https://journals.openedition.org/etudescaribeennes/docannexe/image/12450/img-12-small580.jpg',
    'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/74/95/cc/les-cascades-de-el-ourit.jpg?w=500&h=300&s=1',
    'https://www.tunisiepromo.com/wp-content/uploads/2018/09/Tlemcen-guide-touristique-alg%C3%A9rie0101.jpg',
    'https://journals.openedition.org/etudescaribeennes/docannexe/image/12450/img-12-small580.jpg',
  ];

  List<Widget> getImages() {
    List<Widget> list = [];
    for (var url in urls) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: NetworkImage(url),
        )),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Column(
                  children: getImages(),
                ),
              ),
              Flexible(
                child: Column(
                  children: getImages(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
