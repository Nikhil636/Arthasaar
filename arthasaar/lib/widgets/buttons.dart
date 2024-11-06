import 'package:flutter/material.dart';

class ThemedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ThemedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(context).primaryColor, // Primary color from the theme
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 12), // Adjust padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelLarge, // Text style from the theme
        ),
      ),
    );
  }
}
