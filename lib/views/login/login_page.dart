import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/navigation_bar_view/navigation_bar_view.dart';
import 'package:flutter_project_1/views/sign_up/confirm_email_page.dart';
import 'package:flutter_project_1/views/sign_up/sign_up_page.dart';
import 'package:flutter_project_1/widgets/text_field/rounded_input_field.dart';
import 'package:flutter_project_1/widgets/button/rounded_linear_button.dart';
import 'package:flutter_project_1/widgets/text_field/rounded_password_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../view_models/login/login_provider.dart';
import '../../widgets/dialog/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.autoFillEmail, this.autoFillPwd})
      : super(key: key);
  static const String nameRoute = '/login';
  final String? autoFillEmail, autoFillPwd;
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
    final loginProvider = Provider.of<LoginProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: loginProvider.isLoading,
      color: AppColors.kPrimaryColor,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/img_welcome_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    child: Column(children: []),
                  )
                ],
              ),
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
                          loginProvider.clearTextController();
                        } else {
                          loginProvider.isLoading = false;
                          AuthService()
                              .sendOtp(loginProvider.loginEmailController.text);
                          Navigator.pushNamed(
                              context, ConfirmEmailPage.nameRoute,
                              arguments: false);
                          loginProvider.clearTextController();
                        }
                      } catch (err) {
                        loginProvider.isLoading = false;
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
      ),
    );
  }
}
