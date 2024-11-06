import 'package:arthasaar/constants/theme.dart';
import 'package:arthasaar/services/registration_services.dart';
import 'package:arthasaar/routes/routes.dart';
import 'package:arthasaar/screens/auth/register.dart';
import 'package:arthasaar/screens/auth/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arthasaar/screens/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash, // Change initial route to splash screen
        onGenerateRoute: AppRoutes.generateRoute,
        home: SplashScreen(), // Display the splash screen as the initial screen
      ),
    );
  }
}
