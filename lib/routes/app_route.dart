import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/views/home_screen.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/views/sign_up/sign_up_page.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return CupertinoPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case LoginPage.nameRoute:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
      case SignUpPage.nameRoute:
        return CupertinoPageRoute(builder: (_) => const SignUpPage());
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
      settings: const RouteSettings(
        name: '/error',
      ),
    );
  }
}
