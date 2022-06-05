import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/view_models/login/sign_up_provider.dart';
import 'package:flutter_project_1/views/sign_up/confirm_email_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../configs/color_config.dart';
import '../../widgets/dialog/custom_dialog.dart';
import '../../widgets/text_field/rounded_input_field.dart';
import '../../widgets/button/rounded_linear_button.dart';
import '../../widgets/text_field/rounded_password_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: signUpProvider.isLoading,
      color: AppColors.kPrimaryColor,
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kColor1,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Material(
                              color: AppColors.kColor1, // Button color
                              child: InkWell(
                                splashColor: Colors.grey, // Splash color
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  width: 42.w,
                                  height: 42.h,
                                  child: SvgPicture.asset(
                                    "assets/icons/ic_back.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of(context).backToSignIn,
                            style: TextConfigs.kText16Black,
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context).create,
                            style: TextConfigs.kTextHeader2,
                          ),
                          Text(
                            AppLocalizations.of(context).newAccount,
                            style: TextConfigs.kTextHeader2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'User Name',
                      style: TextConfigs.kTextSubtitle,
                    ),
                    RoundedInputField(
                      controller: signUpProvider.userNameController,
                      inputName: "User Name",
                      icon: Icons.person,
                    ),
                    Text(
                      'Email',
                      style: TextConfigs.kTextSubtitle,
                    ),
                    RoundedInputField(
                      controller: signUpProvider.emailController,
                      inputName: "Email",
                      icon: Icons.person,
                    ),
                    Text(
                      'Password',
                      style: TextConfigs.kTextSubtitle,
                    ),
                    RoundedPasswordField(
                      controller: signUpProvider.pwdController,
                    ),
                    Text(
                      'Confirm Password',
                      style: TextConfigs.kTextSubtitle,
                    ),
                    RoundedPasswordField(
                      controller: signUpProvider.pwdConfirmController,
                      isConfirmPwd: true,
                      pwdToConfirm: signUpProvider.pwdController.text,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      child: RoundedLinearButton(
                          text: "Create",
                          press: () async {
                            try {
                              signUpProvider.isLoading = true;
                              _formKey.currentState?.validate();
                              signUpProvider.createAccountWithEmail();
                              signUpProvider.sendOtp();
                              signUpProvider.clearTextController();
                              Navigator.pushNamed(
                                  context, ConfirmEmailPage.nameRoute,
                                  arguments: true);
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
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextConfigs.kText16BoldBlack,
                            children: [
                              const TextSpan(
                                  text: "I agree to comply with the "),
                              TextSpan(
                                text: "Policy",
                                style: TextConfigs.kText16BoldKprimary,
                              ),
                              const TextSpan(text: " of the application"),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
