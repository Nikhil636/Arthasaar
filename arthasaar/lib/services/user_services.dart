// services/user_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class UserService {
  Future<String> fetchUserBalance() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      final token = prefs.getString('jwt_token');

      if (userId == null || token == null) {
        return "User ID or token is missing";
      }

      final url = '$baseUrl/api/users/$userId';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['user']['balance'].toString();
      } else {
        return "Failed to load balance";
      }
    } catch (e) {
      print("Error fetching balance: $e");
      return "Error loading balance";
    }
  }

  Future<void> storeUserCredentials(String? token, String? userId) async {
    if (token == null || userId == null) {
      throw ArgumentError("Token and user ID cannot be null");
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    await prefs.setString('user_id', userId);
  }
}
