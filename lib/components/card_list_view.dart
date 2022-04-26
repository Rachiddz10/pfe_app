import 'package:flutter/material.dart';
import 'package:pfe_app/screens/place_view.dart';

class CardInListView extends StatelessWidget {
  const CardInListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PlaceView.id);
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "https://dummyimage.com/80x80/add8e6/ffffff&text=TEXT",
              height: 80,
              width: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "JAMA3 LKEBIR",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  Text("Descipton short of touristic site",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      textAlign: TextAlign.left),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
