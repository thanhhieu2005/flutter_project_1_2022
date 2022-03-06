import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:provider/provider.dart';

import '../widgets/rounded_linear_button.dart';

class HomeScreen extends StatelessWidget {
  static const id = "HomeScreen";
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: id),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: AppColors.kColor1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text("HomeScreen"),
            RoundedLinearButton(
                text: "Log out",
                press: () async {
                  await authService.signOut();
                  Navigator.pushAndRemoveUntil(
                      context, LoginPage.route(), (route) => false);
                },
                textColor: Colors.black,
                startColor: Colors.grey,
                endColor: Colors.grey)
          ],
        ),
      ),
    );
  }
}
