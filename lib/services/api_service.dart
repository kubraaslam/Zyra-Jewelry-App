// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api"; // emulator loopback

  Future<Map<String, dynamic>?> login(String login, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"login": login, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"]);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> register(
      String username, String email, String password, String passwordConfirmation) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"]);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null) {
      await http.post(
        Uri.parse("$baseUrl/logout"),
        headers: {"Authorization": "Bearer $token"},
      );
    }

    await prefs.remove("token");
  }
}