import 'package:jewelry_store/models/user.dart';
import 'package:jewelry_store/services/api_service.dart';

class AuthController {
  final ApiService api = ApiService();

  Future<User> login(String login, String password) async {
    final data = await api.login(login, password);
    return User.fromJson(data?["user"]);
  }

  Future<Map<String, dynamic>?> register(
    String username,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final data = await api.register(
      username,
      email,
      password,
      passwordConfirmation,
    );
    return data; // keep the JSON map
  }

  Future<void> logout() async {
    await api.logout();
  }
}
