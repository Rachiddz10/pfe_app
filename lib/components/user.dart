class User {
  static String first = '';
  static String last = '';
  static String email = '';
  static int id = -2;
  static List savedPaths = [];

  static addUser(var json) {
    String fullName = json['name'];
    last = fullName.split(' ').first;
    first = fullName.split(' ').last;
    id = json['id'];
    email = json['email'];
    savedPaths = json['saved_paths'];
  }

  static logoutUser() {
    User.first = '';
    User.last = '';
    User.id = -2;
    User.savedPaths = [];
    User.email = '';
  }


}