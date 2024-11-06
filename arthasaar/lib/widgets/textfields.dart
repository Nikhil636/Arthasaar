import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: theme.textTheme.bodyLarge, // Apply the theme's text style
      decoration: InputDecoration(
        labelText: 'Enter Email',
        hintText: 'example@gmail.com',
        labelStyle: theme.textTheme.titleMedium, // Label color from the theme
        hintStyle: theme.textTheme.bodySmall, // Hint color from the theme
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor), // Border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: theme.primaryColor), // Border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: theme.colorScheme.primary), // Border when focused
        ),
        prefixIcon: Icon(
          Icons.email,
          color: theme.iconTheme.color, // Icon color from theme
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField(
      {Key? key, required this.controller, required String hintText})
      : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return TextFormField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      style: theme.textTheme.bodyLarge, // Apply the theme's text style
      decoration: InputDecoration(
        labelText: 'Enter Password',
        labelStyle: theme.textTheme.titleMedium, // Label color from the theme
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor), // Border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: theme.primaryColor), // Border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: theme.colorScheme.primary), // Border when focused
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: theme.iconTheme.color, // Icon color from theme
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: theme.iconTheme.color, // Icon color from theme
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }
}

class FullNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const FullNameTextField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return TextFormField(
      controller: controller,
      style: theme.textTheme.bodyLarge, // Apply the theme's text style
      decoration: InputDecoration(
        labelText: 'Full Name',
        labelStyle: theme.textTheme.titleMedium, // Label color from the theme
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor), // Border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: theme.primaryColor), // Border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: theme.colorScheme.primary), // Border when focused
        ),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            if (value.length < 2) {
              return 'Name should be at least 2 characters long';
            }
            return null; // Return null if the input is valid
          },
    );
  }
}
