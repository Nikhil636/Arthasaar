// registration_page.dart
import 'package:arthasaar/widgets/buttons.dart';
import 'package:arthasaar/widgets/textfields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:arthasaar/routes/routes.dart';
import 'package:provider/provider.dart';
import '../../services/registration_services.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      Provider.of<RegistrationProvider>(context, listen: false).registerUser(
        _fullNameController.text,
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registered successfully!')),
      );
      await Future.delayed(Duration(seconds: 2)); // Delay to show the snackbar
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<RegistrationProvider>(
        builder: (context, provider, child) {
          if (provider.isRegistered) {
            provider.resetStatus(); // Reset status to avoid double navigation
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            });
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height / 12),
                    FullNameTextField(controller: _fullNameController),
                    SizedBox(height: 24.0),
                    EmailTextField(controller: _emailController),
                    SizedBox(height: 24.0),
                    PasswordTextField(
                      controller: _passwordController,
                      hintText: 'Enter Password',
                    ),
                    SizedBox(height: 24.0),
                    PasswordTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                    ),
                    SizedBox(height: 40.0),
                    provider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ThemedButton(
                            text: 'Register',
                            onPressed: _registerUser,
                          ),
                    SizedBox(height: 24.0),
                    if (provider.message.isNotEmpty && !provider.isRegistered)
                      Center(
                        child: Text(
                          provider.message,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                          children: [
                            TextSpan(
                                text: 'Already registered? ',
                                style: Theme.of(context).textTheme.bodyLarge),
                            TextSpan(
                              text: 'Login here.',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, AppRoutes.login);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
