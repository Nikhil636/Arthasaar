// services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class AuthService {
  Future<Map<String, String>> loginUser(String email, String password) async {
    final url = '$baseUrl/api/auth/login';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'token': data['token'],
        'user_id': data['user_id'].toString(),
      };
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
}
