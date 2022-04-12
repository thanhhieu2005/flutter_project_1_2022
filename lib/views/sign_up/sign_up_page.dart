import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../configs/color_config.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/rounded_input_field.dart';
import '../../widgets/rounded_linear_button.dart';
import '../../widgets/rounded_password_field.dart';
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
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
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
                    inputName: "User Name",
                    icon: Icons.person,
                    onChanged: (value) {
                      authService.signUpEmail = value;
                    }),
                Text(
                  'Email',
                  style: TextConfigs.kTextSubtitle,
                ),
                RoundedInputField(
                    inputName: "Email",
                    icon: Icons.person,
                    onChanged: (value) {
                      authService.signUpEmail = value;
                    }),
                Text(
                  'Password',
                  style: TextConfigs.kTextSubtitle,
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    authService.signUpPassword = value;
                  },
                ),
                Text(
                  'Confirm Password',
                  style: TextConfigs.kTextSubtitle,
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    authService.signUpPassword = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: RoundedLinearButton(
                      text: "Sign Up",
                      press: () async {
                        try {
                          await authService.createUserWithEmailAndPassword(
                              authService.signUpEmail,
                              authService.signUpPassword);
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
                          const TextSpan(text: "I agree with the "),
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
    );
  }
}
