class City {
  final String name;
  final int id;
  final String picture;

  City({required this.name,required this.id, required this.picture});

  factory City.fromJson(Map<String, dynamic> json) {
    City city = City(
      id: json['id'],
      name: json['name'],
      picture: json['image'],
    );
    return city;
  }
}