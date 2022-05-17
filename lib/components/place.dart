class Place {
  final int id;

  Place({required this.id});

  factory Place.fromJson(Map<String, dynamic> json) {
    Place place = Place(
      id: json['id'],
    );
    return place;
  }
}