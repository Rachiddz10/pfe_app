class User {
  static String? first;
  static String? last;
  static String? email;
  static int? id;
  static List? savedPaths = [];

  static addUser(var json) {
    String fullName = json['name'];
    last = fullName.split(' ').first;
    first = fullName.split(' ').last;
    id = json['id'];
    email = json['email'];
    savedPaths = json['saved_paths '];
  }


}