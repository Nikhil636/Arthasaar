import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:arthasaar/config.dart'; // Import the config file

class RegistrationProvider with ChangeNotifier {
  bool isLoading = false;
  bool isRegistered = false; // Success flag
  String message = '';

  Future<void> registerUser(
      String fullName, String username, String email, String password) async {
    isLoading = true;
    isRegistered = false;
    message = '';
    notifyListeners();

    final url = Uri.parse('$baseUrl/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_name': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        isRegistered = true;
        message = "User registered successfully";
      } else {
        final responseData = json.decode(response.body);
        message = responseData['message'] ?? 'Registration failed';
      }
    } catch (error) {
      message = 'An error occurred. Please try again.';
      print('Error: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetStatus() {
    isRegistered = false;
    message = '';
    notifyListeners();
  }
}
