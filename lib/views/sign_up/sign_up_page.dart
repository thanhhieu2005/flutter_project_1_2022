import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/view_models/login/sign_up_provider.dart';
import 'package:flutter_project_1/views/sign_up/confirm_email_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../configs/auth_config.dart';
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
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.kPrimaryColor,
        size: 32.h,
      ),
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
                                  height: 42.w,
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
                      height: 20.h,
                    ),
                    Text(
                      AppLocalizations.of(context).userName,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RoundedInputField(
                      controller: signUpProvider.userNameController,
                      inputName: AppLocalizations.of(context).userName,
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      AppLocalizations.of(context).email,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RoundedInputField(
                      controller: signUpProvider.emailController,
                      inputName: AppLocalizations.of(context).email,
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      AppLocalizations.of(context).yourPwd,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RoundedPasswordField(
                      controller: signUpProvider.pwdController,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      AppLocalizations.of(context).confirmPwd,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RoundedPasswordField(
                      controller: signUpProvider.pwdConfirmController,
                      isConfirmPwd: true,
                      pwdToConfirm: signUpProvider.pwdController.text,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      AppLocalizations.of(context).gender,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Consumer<SignUpProvider>(
                              builder: (context, provider, child) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.changeGenderMale();
                                  },
                                  child: provider.isMale
                                      ? const Image(
                                          fit: BoxFit.scaleDown,
                                          image: AssetImage(
                                              "assets/images/man_gender_selected.png"))
                                      : const Image(
                                          fit: BoxFit.scaleDown,
                                          image: AssetImage(
                                              "assets/images/man_gender_unselected.png")),
                                );
                              },
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Consumer<SignUpProvider>(
                              builder: (context, provider, child) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.changeGenderFemale();
                                  },
                                  child: provider.isWoman
                                      ? const Image(
                                          fit: BoxFit.scaleDown,
                                          image: AssetImage(
                                              "assets/images/woman_gender_selected.png"))
                                      : const Image(
                                          fit: BoxFit.scaleDown,
                                          image: AssetImage(
                                              "assets/images/woman_gender_unselected.png")),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<SignUpProvider>(
                            builder: (context, provider, child) {
                          return Checkbox(
                              activeColor: AppColors.kPrimaryColor,
                              checkColor: AppColors.kColor1,
                              value: provider.getCheckPolicyStatus(),
                              onChanged: (bool? value) {
                                setState(() {
                                  provider.setCheckPolicyStatus(value ?? false);
                                });
                              });
                        }),
                        Flexible(
                          child: RichText(
                            maxLines: 10,
                            softWrap: true,
                            text: TextSpan(
                              style: TextConfigs.kText16Black,
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)
                                            .termsAppCreateAccount +
                                        " "),
                                TextSpan(
                                  text: AppLocalizations.of(context).policy,
                                  style: TextConfigs.kText16BoldKprimary,
                                ),
                                TextSpan(
                                    text: " " +
                                        AppLocalizations.of(context)
                                            .ofTheApplication),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.h),
                      child: RoundedLinearButton(
                          text: "Create",
                          press: () async {
                            // try {
                            if (signUpProvider.isValidForSendingOtp()) {
                              try {
                                await signUpProvider.createAccountWithEmail();
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
                              await signUpProvider.getCurrentUser();
                              Navigator.pushNamed(
                                      context, ConfirmEmailPage.nameRoute,
                                      arguments: true)
                                  .then((value) =>
                                      signUpProvider.clearTextController());
                            }
                            // } catch (error) {
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) => CustomDialog(
                            //       title: "Failed",
                            //       description: error.toString(),
                            //       image: 'cancel.png',
                            //       hasDescription: true,
                            //     ),
                            //   );
                            // }
                          },
                          textColor: Colors.white,
                          startColor: AppColors.kPrimaryColor,
                          endColor: AppColors.kPrimaryColor),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
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
