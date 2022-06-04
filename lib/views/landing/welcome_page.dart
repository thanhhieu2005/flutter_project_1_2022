import 'package:flutter/material.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../configs/color_config.dart';
import '../../configs/text_config.dart';
import '../../widgets/rounded_linear_button.dart';
import '../sign_up/sign_up_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const String nameRoute = '/welcome';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const WelcomePage(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              padding: EdgeInsets.only(top: 60.h),
              child: Center(
                child: Image.asset(
                  "assets/images/bg_welcome.png",
                  height: 500.h,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.w, top: 25.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).findInterest,
                      style: TextConfigs.kText24SemiBoldBlack,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      AppLocalizations.of(context).placeToDiscover,
                      style: TextConfigs.kText24SemiBoldPrimary,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      AppLocalizations.of(context).weShareAll,
                      style: TextConfigs.kText16Grey,
                    ),
                    Text(
                      AppLocalizations.of(context).tourGuide,
                      style: TextConfigs.kText16Grey,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                      ),
                      child: RoundedLinearButton(
                          text: AppLocalizations.of(context).signUp,
                          press: () {
                            Navigator.push(context, SignUpPage.route());
                          },
                          isAllCap: false,
                          textColor: Colors.white,
                          startColor: AppColors.kPrimaryColor,
                          endColor: AppColors.kPrimaryColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                      color: AppColors.kBackgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).alreadyHaveAccount,
                            style: TextConfigs.kText16Black,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginPage.nameRoute, (route) => false);
                            },
                            child: Text(
                              AppLocalizations.of(context).signIn,
                              style: TextConfigs.kText16Primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
