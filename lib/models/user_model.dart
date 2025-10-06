class UserModel {
  final String id;
  final String username;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'].toString(),
      username: json['user']['username'],
      email: json['user']['email'],
      token: json['token'], // token is at root level
    );
  }

  UserModel copyWith({String? username, String? email}) {
    return UserModel(
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      token: token,
    );
  }
}