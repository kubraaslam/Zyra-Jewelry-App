class User {
  final int id;
  final String username;
  final String email;
  final String role;
  final String? membership;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.membership,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      membership: json['membership'],
    );
  }
}
