class CategoryPlace {
  final int? id;
  final String? name;

  CategoryPlace({required this.id, required this.name});

  factory CategoryPlace.fromJson(Map<String, dynamic> json) {
    CategoryPlace category = CategoryPlace(
      id: json['id'],
      name: json['name'],
    );
    return category;
  }
}
