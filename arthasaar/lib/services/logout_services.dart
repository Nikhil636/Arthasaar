// logout_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../config.dart'; // Adjust path as necessary

Future<void> logoutUser(BuildContext context) async {
  // Call the logout API
  final response = await http.post(
    Uri.parse('$baseUrl/api/auth/logout'), // Replace with actual logout API URL
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Clear user session (e.g., JWT token) from shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'jwt_token'); // Replace 'auth_token' with the key used for the token

    // Debugging step to verify the token is cleared
    String? token = prefs.getString('jwt_token');
    if (token == null) {
      print('Token successfully cleared!');
    }

    // Navigate to login page after clearing the token
    Navigator.pushReplacementNamed(context, '/login');
  } else {
    // Handle logout failure (show error message)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed: ${response.body}')),
    );
  }
}
