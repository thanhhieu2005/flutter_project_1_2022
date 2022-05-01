import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_project_1/views/sign_up/confirm_email_page.dart';
import 'package:flutter_project_1/views/sign_up/sign_up_page.dart';
import 'package:flutter_project_1/widgets/rounded_input_field.dart';
import 'package:flutter_project_1/widgets/rounded_linear_button.dart';
import 'package:flutter_project_1/widgets/rounded_password_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_models/login_provider.dart';
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
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedInputField(
              controller: loginProvider.loginEmailController,
              inputName: "Email",
              icon: Icons.person,
            ),
            SizedBox(
              height: 10.h,
            ),
            RoundedPasswordField(
              controller: loginProvider.loginPwdController,
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forget your password ?",
                style: TextConfigs.kText16BoldBlack,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            RoundedLinearButton(
                text: "Log In",
                press: () async {
                  if (loginProvider.loginEmailController.text.isNotEmpty &&
                      loginProvider.loginPwdController.text.isNotEmpty) {
                    try {
                      var isConfirmEmail =
                          await loginProvider.signInWithEmail();
                      if (isConfirmEmail) {
                        Navigator.pushAndRemoveUntil(context,
                            NavigationBarView.route(), (route) => false);
                      } else {
                        AuthService()
                            .sendOtp(loginProvider.loginEmailController.text);
                        Navigator.pushNamed(
                            context, ConfirmEmailPage.nameRoute);
                      }
                      loginProvider.clearTextController();
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
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextConfigs.kText16BoldBlack,
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, SignUpPage.route());
                  },
                  child: Text(
                    "Sign up",
                    style: TextConfigs.kText16BoldKprimary,
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
