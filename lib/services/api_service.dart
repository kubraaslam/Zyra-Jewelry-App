import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jewelry_store/services/storage_service.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api"; // emulator loopback

  //Login with API
  static Future<Map<String, dynamic>> login(
    String login,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {'Accept': 'application/json'},
            body: {'login': login, 'password': password},
          )
          .timeout(const Duration(seconds: 20)); // <-- timeout here

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
          json.decode(response.body)['message'] ?? 'Login failed',
        );
      }
    } on http.ClientException catch (e) {
      throw Exception('Network error: $e');
    } on TimeoutException {
      throw Exception('Request timed out. Please try again.');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  //Register with API
  static Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Accept': 'application/json'},
      body: {
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(
        json.decode(response.body)['message'] ?? 'Registration failed',
      );
    }
  }

  // Fetch Products
  static Future<List<dynamic>> getProducts() async {
    final token = await StorageService.read('token'); // just string key
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}