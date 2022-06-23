class User {
  static String first = '';
  static String last = '';
  static String email = '';
  static int id = -2;
  static List savedPaths = [];
  static List<int> likedPlaces = [];

  static addUser(var json) {
    List listFixed = [];
    String fullName = json['name'];
    last = fullName.split(' ').first;
    first = fullName.split(' ').last;
    id = json['id'];
    email = json['email'];
    savedPaths = json['saved_paths'];
    listFixed = json['liked_places'];

    for (int i = 0; i < listFixed.length; i++) {
      likedPlaces.add(listFixed[i]['post_id']);
    }
  }

  static logoutUser() {
    User.first = '';
    User.last = '';
    User.id = -2;
    User.savedPaths = [];
    User.email = '';
    User.likedPlaces = [];
  }


}