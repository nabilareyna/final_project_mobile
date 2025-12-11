class UserModel {
  final String uid;
  final String email;
  final String name;
  final List<String> favorites;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.favorites,
  });


  factory UserModel.fromJson(String uid, Map<String, dynamic> json) {
    return UserModel(
      uid: uid,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      favorites: (json['favorites'] != null)
          ? List<String>.from(json['favorites'])
          : [],
    );
  }

  /// Convert UserModel → JSON (for saving back to RTDB)
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "favorites": favorites,
    };
  }
}
