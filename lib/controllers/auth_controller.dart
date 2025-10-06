import 'package:flutter/material.dart';
import 'package:jewelry_store/models/user_model.dart';
import 'package:jewelry_store/services/api_service.dart';
import 'package:jewelry_store/services/storage_service.dart';

class AuthController with ChangeNotifier {
  UserModel? _user;
  bool _loading = false;

  UserModel? get user => _user;
  bool get loading => _loading;

  // Login
  Future<void> login(String login, String password) async {
    _loading = true;
    notifyListeners();

    try {
      final response = await ApiService.login(login, password);

      // Save token to local storage
      final token = response['token'];
      await StorageService.write('token', token);

      // Parse user (depends on your API response structure)
      _user = UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  // Register
  Future<void> register(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    _loading = true;
    notifyListeners();

    try {
      final data = await ApiService.register(
        username,
        email,
        password,
        confirmPassword,
      );
      _user = UserModel.fromJson(data);
    } catch (e) {
      _loading = false;
      notifyListeners();
      rethrow;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await StorageService.delete('token');
    _user = null;
    notifyListeners();
  }

  void updateUser(UserModel updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }
}