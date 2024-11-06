import 'package:arthasaar/config.dart';
import 'package:arthasaar/constants/theme.dart';
import 'package:arthasaar/routes/routes.dart';
import 'package:arthasaar/services/auth_services.dart';
import 'package:arthasaar/services/user_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:arthasaar/widgets/textfields.dart';
import 'package:arthasaar/widgets/buttons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final data = await _authService.loginUser(
        _emailController.text,
        _passwordController.text,
      );
      print("Login response data: $data");

      final token = data['token'];
      final userId = data['user_id'];

      await _userService.storeUserCredentials(token, userId);

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $error')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppTheme.primaryColorLight,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.0), // Adjust the radius as needed
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(),
                  Center(
                    child: Image.asset(
                      'assets/loginPage.png',
                      height: MediaQuery.sizeOf(context).height / 5,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login',
                    style: GoogleFonts.chakraPetch(
                      fontSize: 32, // Large font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4.0,
                          color: AppTheme.primaryColorLight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 20,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EmailTextField(controller: _emailController),
                    SizedBox(height: 24.0),
                    PasswordTextField(
                        controller: _passwordController,
                        hintText: 'Enter Password'),
                    SizedBox(height: 40.0),
                    isLoading
                        ? SizedBox(
                            width: 50, child: CircularProgressIndicator())
                        : ThemedButton(text: 'Login', onPressed: _loginUser),
                    SizedBox(height: 24),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'New here? ',
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: 'Register now.',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, AppRoutes.registration),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
