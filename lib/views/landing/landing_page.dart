import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../sign_up/confirm_email_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    getUserPref();
  }

  void getUserPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> userJson = {};
    if (pref.getString('user') != null) {
      userJson = jsonDecode(pref.getString('user')!);
    }
    localCurrentUser = VatractionUser.fromJson(userJson);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder(
      stream: authService.user,
      builder: (_, AsyncSnapshot<VatractionUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
<<<<<<< HEAD
          final User? user = snapshot.data;
          if (!localCurrentUser.isConfirmEmail) {
            authService.sendOtp(localCurrentUser.email);
=======
          final VatractionUser? user = snapshot.data;
          if (user != null && !localCurrentUser.isConfirmEmail) {
            localCurrentUser = user;
            authService.sendOtp(user.email);
>>>>>>> 3f40c072208e3026d3eddeb0f7256bbbb56c8c94
            return const LoginPage();
          }
          return user == null ? const LoginPage() : const NavigationBarView();
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
