class User {
  int id;
  String name;
  String? email;
  String? photoUrl;

  User({required this.id, required this.name, this.email, this.photoUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
    );
  }
}
