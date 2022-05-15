class PlaceThumb {
  final String? name;
  final String? summary;
  final String? thumb;

  PlaceThumb({required this.name, required this.summary, required this.thumb});

  factory PlaceThumb.fromJson(Map<String, dynamic> json) {
    PlaceThumb place = PlaceThumb(
      name: json['name'],
      summary: json['summary'],
      thumb: json['thumb'],
    );
    return place;
  }
}