import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/home_screen.dart';
import 'package:flutter_project_1/views/sign_up/sign_up_page.dart';
import 'package:flutter_project_1/widgets/rounded_input_field.dart';
import 'package:flutter_project_1/widgets/rounded_linear_button.dart';
import 'package:flutter_project_1/widgets/rounded_password_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String nameRoute = '/login';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LoginPage(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "", password = "";

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedInputField(
                hintText: "Email",
                inputName: "Email",
                icon: Icons.person,
                onChanged: (value) {
                  authService.loginEmail = value;
                }),
            RoundedPasswordField(
              onChanged: (value) {
                authService.loginPassword = value;
              },
              hintText: "Password",
            ),
            SizedBox(
              height: 24.h,
            ),
            RoundedLinearButton(
                text: "Log In",
                press: () async {
                  if (authService.loginEmail.isNotEmpty &&
                      authService.loginPassword.isNotEmpty) {
                    try {
                      await authService.signInWithEmailAndPassword(
                          authService.loginEmail, authService.loginPassword);
                      Navigator.pushAndRemoveUntil(
                          context, HomeScreen.route(), (route) => false);
                    } catch (err) {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          title: "Failed",
                          description: err.toString(),
                          image: 'cancel.png',
                          hasDescription: true,
                        ),
                      );
                    }
                  }
                },
                textColor: Colors.white,
                startColor: AppColors.kPrimaryColor,
                endColor: AppColors.kPrimaryColor),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Forget your password ?",
              style: TextConfigs.kText16BoldBlack,
            ),
            Text(
              "Forget your password ?",
              style: TextConfigs.kText16_1,
            )
          ],
        )),
      ),
    );
  }
}
