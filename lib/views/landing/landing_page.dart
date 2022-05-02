import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../sign_up/confirm_email_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user != null && !user.isConfirmEmail) {
            localCurrentUser = user;
            authService.sendOtp(user.email);
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
