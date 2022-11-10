// ignore_for_file: file_names

class UserData {
  UserData({this.message, this.user, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      message: json["message"].toString(),
      user: User.fromJson(json['user']),
      token: json["token"].toString(),
    );
  }
  final String? message;
  final User? user;
  final String? token;
}

class User {
  User(
      {required this.name,
      required this.email,
      required this.id,
      required this.role,
      required this.picture,});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"].toString(),
      email: json["email"].toString(),
      id: json["_id"].toString(),
      role: json["role"].toString(),
      picture: json["picture"],
    );
  }
  final String name;
  final String email;
  final String id;
  final String role;
  final String picture;
}

// ignore: always_specify_types
Map<String, dynamic> jsonUserInfos = {};