import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/views/account/account_screen.dart';
import 'package:flutter_project_1/views/account/sub_screens/change_pwd_screen.dart';
import 'package:flutter_project_1/views/account/sub_screens/per_info_screen.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_project_1/views/sign_up/sign_up_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationBarView.id:
        return CupertinoPageRoute(
          builder: (_) => const NavigationBarView(),
        );
      case LoginPage.nameRoute:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
      case SignUpPage.nameRoute:
        return CupertinoPageRoute(builder: (_) => const SignUpPage());
      case AccountScreen.nameRoute:
        return CupertinoPageRoute(builder: (_) => const AccountScreen());
      // Sub Screen of Account Screen
      case PersonalInfoScreen.nameRoute:
        return PersonalInfoScreen.route();
      case ChangePasswordScreen.nameRoute:
        return ChangePasswordScreen.route();
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
