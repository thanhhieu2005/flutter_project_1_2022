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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  AppLocalizations.of(context).findInterest,
                  style: TextConfigs.kText22SemiBoldPrimary,
                ),
                SizedBox(
                  width: 30.h,
                ),
                Text(
                  AppLocalizations.of(context).placeToDiscover,
                  style: TextConfigs.kText22SemiBoldPrimary,
                ),
                Text(
                  AppLocalizations.of(context).weShareAll,
                  style: TextConfigs.kText16Secondary,
                ),
                Container(
                  color: AppColors.kBackgroundColor,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/bg_welcome.png",
                          fit: BoxFit.fill,
                          height: 600.h,
                          width: size.width,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
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
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).alreadyHaveAccount,
                        style: TextConfigs.kText16Secondary,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginPage.nameRoute, (route) => false);
                        },
                        child: Text(
                          AppLocalizations.of(context).signIn,
                          style: TextConfigs.kText16Primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
