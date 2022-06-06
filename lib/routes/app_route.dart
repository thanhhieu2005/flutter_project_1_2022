import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/views/account/setting_account_screen.dart';
import 'package:flutter_project_1/views/account/sub_screens/change_avatar_screen.dart';
import 'package:flutter_project_1/views/account/sub_screens/change_pwd_screen.dart';
import 'package:flutter_project_1/views/account/sub_screens/per_info_screen.dart';
import 'package:flutter_project_1/views/discovery/discovery_screen.dart';
import 'package:flutter_project_1/views/home/home_screen.dart';
import 'package:flutter_project_1/views/home/sub_screens/post_detail_screen.dart';
import 'package:flutter_project_1/views/home/sub_screens/type_screen.dart';
import 'package:flutter_project_1/views/landing/welcome_page.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_project_1/views/sign_up/confirm_email_page.dart';
import 'package:flutter_project_1/views/sign_up/sign_up_page.dart';

import '../views/home/sub_screens/search_screen.dart';

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
      case ConfirmEmailPage.nameRoute:
        return CupertinoPageRoute(
            builder: (_) => const ConfirmEmailPage(),
            settings: RouteSettings(arguments: settings.arguments));
      case WelcomePage.nameRoute:
        return CupertinoPageRoute(builder: (_) => const WelcomePage());

      // Create new post screen
      // case CreatePostScreen.nameRoute:
      //   return CreatePostScreen.route();

      /* Account Screen */
      case SettingAccountScreen.nameRoute:
        return CupertinoPageRoute(builder: (_) => const SettingAccountScreen());
      // Sub Screen of Account Screen
      case PersonalInfoScreen.nameRoute:
        return PersonalInfoScreen.route(settings);
      case ChangePasswordScreen.nameRoute:
        return ChangePasswordScreen.route();
      case ChangeAvatarScreen.nameRoute:
        return ChangeAvatarScreen.route(settings);

      /* Home Screen */
      case HomeScreen.nameRoute:
        return HomeScreen.route();
      // Sub Screen of Account Screen
      case SearchScreen.nameRoute:
        return SearchScreen.route();
      case PostDetailScreen.nameRoute:
        return PostDetailScreen.route(settings);
      case TypeScreen.nameRoute:
        return TypeScreen.route(settings);

      /* Discovery Screen */
      case DiscoveryScreen.nameRoute:
        return DiscoveryScreen.route();

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
