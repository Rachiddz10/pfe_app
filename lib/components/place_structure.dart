class PlaceStructure {
  final int? idPlace;
  final String? name;
  final String? description;
  final String? thumb;
  final int? price;
  final int? time;
  final String? lat;
  final String? long;
  final String? summary;

  PlaceStructure({
    required this.idPlace,
    required this.name,
    required this.description,
    required this.thumb,
    required this.price,
    required this.time,
    required this.lat,
    required this.long,
    required this.summary,
  });

  factory PlaceStructure.fromJson(int idNum, Map<String, dynamic> json, List<dynamic> jsonMeta, List<dynamic> jsonGeo, Map<String, dynamic> jsonThumb) {
    PlaceStructure place = PlaceStructure(
      idPlace: idNum,
      name: json['name'],
      description: json['description'],
      thumb: json['thumb'],
      price: jsonMeta[0]['price'],
      time: jsonMeta[0]['time'],
      lat: jsonGeo[0]['lat'],
      long: jsonGeo[0]['long'],
      summary: jsonThumb['summary'],
    );
    return place;
  }
}
