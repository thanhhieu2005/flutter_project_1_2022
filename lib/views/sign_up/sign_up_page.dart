import 'package:flutter/material.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../configs/color_config.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/rounded_input_field.dart';
import '../../widgets/rounded_linear_button.dart';
import '../../widgets/rounded_password_field.dart';
import '../login/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String nameRoute = '/signup';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SignUpPage(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInputField(
              hintText: "Email",
              inputName: "Email",
              icon: Icons.person,
              onChanged: (value) {
                authService.signUpEmail = value;
              }),
          RoundedPasswordField(
            onChanged: (value) {
              authService.signUpPassword = value;
            },
            hintText: "Password",
          ),
          RoundedLinearButton(
              text: "Sign Up",
              press: () async {
                try {
                  await authService.createUserWithEmailAndPassword(
                      authService.signUpEmail, authService.signUpPassword);
                  Navigator.pop(context);
                } catch (error) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: "Failed",
                      description: error.toString(),
                      image: 'cancel.png',
                      hasDescription: true,
                    ),
                  );
                }
              },
              textColor: Colors.white,
              startColor: AppColors.kPrimaryColor,
              endColor: AppColors.kPrimaryColor),
          SizedBox(
            height: 24,
          ),
          RoundedLinearButton(
              text: "Log In",
              press: () {
                Navigator.pop(context);
              },
              textColor: Colors.black,
              startColor: Colors.grey,
              endColor: Colors.grey)
        ],
      )),
    );
  }
}
