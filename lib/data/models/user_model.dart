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

class UsersResponse {
  int total;
  int page;
  List<User> data = [];

  UsersResponse({required this.total, required this.page, required this.data});

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return UsersResponse(
      total: json['data']['total'],
      page: json['data']['current_page'],
      data: List<User>.from(
        json['data']['data'].map((model) => User.fromJson(model)),
      ),
    );
  }
}
