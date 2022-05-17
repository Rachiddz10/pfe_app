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
}