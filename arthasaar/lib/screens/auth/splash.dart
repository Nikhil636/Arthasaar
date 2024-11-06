import 'package:arthasaar/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // 1 second for the animation
    );

    // Define opacity animation (fading in)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Define scaling animation (scaling up)
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Start the animation
    _controller.forward();

    // Check for login status after the animation completes
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token'); // Check for saved token

      // Navigate to the correct screen based on login status
      if (token != null && token.isNotEmpty) {
        // Token found, navigate to Home Screen
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        // Token not found, navigate to Login Screen
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image covering entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/splash_bg.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value, // Fading effect
                  child: Transform.scale(
                    scale: _scaleAnimation.value, // Scaling effect
                    child: Text(
                      'ArthaSaar',
                      style: TextStyle(
                        fontSize: 40, // Large font size for the title
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
