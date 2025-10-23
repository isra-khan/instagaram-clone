import 'package:flutter/material.dart';
import 'package:instagramclone/login_screen.dart';
import 'package:instagramclone/routes/routes.dart';
import 'package:instagramclone/signup_screen.dart';

class AppPages {
  // Define route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case Routes.signin:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
