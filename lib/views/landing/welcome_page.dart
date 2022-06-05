import 'package:flutter/material.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../configs/color_config.dart';
import '../../configs/text_config.dart';
import '../../widgets/button/rounded_linear_button.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img_welcome_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context).findInterest,
                        style: TextConfigs.kText32SemiBoldLightPrimary,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        AppLocalizations.of(context).placeToDiscover,
                        style: TextConfigs.kText32SemiBoldWhite,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 25.h),
              child: Column(
                children: [
                  RoundedLinearButton(
                      text: AppLocalizations.of(context).signIn,
                      press: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginPage.nameRoute, (route) => false);
                      },
                      isAllCap: false,
                      isTextBool: true,
                      textColor: Colors.white,
                      startColor: Colors.black.withOpacity(0.35),
                      endColor: Colors.black.withOpacity(0.35)),
                  SizedBox(height: 20.h),
                  RoundedLinearButton(
                      text: AppLocalizations.of(context).create,
                      press: () {
                        Navigator.push(context, SignUpPage.route());
                      },
                      isAllCap: false,
                      isTextBool: true,
                      textColor: AppColors.kPrimaryColor,
                      startColor: AppColors.kColor1,
                      endColor: AppColors.kColor1),
                ],
              ),
            ),
            Text(
              AppLocalizations.of(context).weShareAll,
              style: TextConfigs.kText14White,
            ),
            Text(
              AppLocalizations.of(context).tourGuide,
              style: TextConfigs.kText14White,
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
