import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/landing/welcome_page.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/users/user.dart';
import '../sign_up/confirm_email_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const String nameRoute = '/landing';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const WelcomePage(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder(
      stream: authService.user,
      builder: (_, AsyncSnapshot<VatractionUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final VatractionUser? user = snapshot.data;
          if (user != null && !localCurrentUser.isConfirmEmail!) {
            localCurrentUser = user;
            return const LoginPage();
          }
          return user == null ? const WelcomePage() : const NavigationBarView();
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: spinkit),
          );
        }
      },
    );
  }

  final spinkit = const SpinKitFoldingCube(
    color: AppColors.kPrimaryColor,
    size: 40.0,
  );
}
