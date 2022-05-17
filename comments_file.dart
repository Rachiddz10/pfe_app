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