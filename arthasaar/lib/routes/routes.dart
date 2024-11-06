// lib/routes/routes.dart

import 'package:arthasaar/screens/auth/login.dart';
import 'package:arthasaar/screens/auth/register.dart';
import 'package:arthasaar/screens/auth/splash.dart';
import 'package:arthasaar/screens/main/home.dart';
import 'package:arthasaar/screens/main/pool.dart';
import 'package:arthasaar/screens/main/pool_list.dart';
import 'package:arthasaar/screens/main/transactions.dart';
import 'package:arthasaar/screens/payment/pay.dart';
import 'package:flutter/material.dart';

import '../screens/main/pool_creation.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String home = '/home';
  static const String groups = '/groups';
  static const String transactions = '/transactions';
  static const String pools = '/pools';
  static const String pool = '/pool';
  static const String createpool = '/createpool';
  static const String payment = '/payment';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registration:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case pools:
        return MaterialPageRoute(builder: (_) => PoolListScreen());
      case transactions:
        return MaterialPageRoute(builder: (_) => TransactionPage());
      case pool:
        return MaterialPageRoute(builder: (_) => PoolScreen());
      case createpool:
        return MaterialPageRoute(builder: (_) => PoolCreationScreen());
      case payment:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage()); // Default route
    }
  }
}
