
class GalleryClass {
  final int? id;
  final String? type;
  final String? uri;
  final String? title;

  GalleryClass({required this.id, required this.type, required this.uri, required this.title});

  factory GalleryClass.fromJson (Map<String, dynamic> json) {
    GalleryClass gallery = GalleryClass(
      id: json['id'],
      type: json['mime_type'],
      uri: json['uri'],
      title: json['title'],
    );
    return gallery;
  }
}
