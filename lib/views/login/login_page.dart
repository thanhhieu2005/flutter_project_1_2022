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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.kPrimaryColor,
        size: 32.h,
      ),
      inAsyncCall: loginProvider.isLoading,
      color: AppColors.kPrimaryColor,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img_welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, left: 20.w),
                        child: Text(
                          AppLocalizations.of(context).welcomeBack,
                          style: TextConfigs.kText31SemiBoldWhite,
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.2),
                          ),
                          margin: EdgeInsets.only(top: 20.h),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context).signInToJoinIn,
                                style: TextConfigs.kText16White,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                AppLocalizations.of(context).amazingJourney,
                                style: TextConfigs.kText24_2.copyWith(
                                  color: AppColors.kTextLightPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: 0.7,
                      child: Container(
                        padding: EdgeInsets.only(left: 40.w, right: 40.w),
                        color: AppColors.kColor1,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 50.h),
                              child: Column(children: [
                                RoundedInputField(
                                  hasHint: true,
                                  fillColor: AppColors.kLightBlueBackGround,
                                  controller:
                                      loginProvider.loginEmailController,
                                  inputName: AppLocalizations.of(context).email,
                                  icon: Icons.person,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                RoundedPasswordField(
                                  hasHint: true,
                                  hintText:
                                      AppLocalizations.of(context).yourPwd,
                                  fillColor: AppColors.kLightBlueBackGround,
                                  controller: loginProvider.loginPwdController,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forget your password ?",
                                    style: TextConfigs.kText16kPrimary,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                RoundedLinearButton(
                                    isAllCap: false,
                                    text: AppLocalizations.of(context).signIn,
                                    press: () async {
                                      if (loginProvider.loginEmailController
                                              .text.isNotEmpty &&
                                          loginProvider.loginPwdController.text
                                              .isNotEmpty) {
                                        try {
                                          loginProvider.setLoadingStatus(true);
                                          var isConfirmEmail =
                                              await loginProvider
                                                  .signInWithEmail();
                                          if (isConfirmEmail) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                NavigationBarView.route(),
                                                (route) => true);
                                          } else {
                                            AuthService().sendOtp(loginProvider
                                                .loginEmailController.text);
                                            Navigator.pushNamed(context,
                                                ConfirmEmailPage.nameRoute,
                                                arguments: false);
                                          }
                                          loginProvider.clearTextController();
                                        } catch (err) {
                                          loginProvider.setLoadingStatus(false);
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
                                      style: TextConfigs.kText16kPrimary,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context, SignUpPage.route());
                                      },
                                      child: Text(
                                        "Sign up",
                                        style: TextConfigs.kText16BoldKprimary,
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: -45,
                              child: Center(
                                child: Image(
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  fit: BoxFit.cover,
                                  image: const AssetImage(
                                      "assets/images/small_app_logo.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
