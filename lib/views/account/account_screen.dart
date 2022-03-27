import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/account/widgets/setting_app_item.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  static const String nameRoute = '/account_screeen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const AccountScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final currentHour = DateTime.now().hour;
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 25.w,
                  top: 30.h,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80.h,
                      height: 80.h,
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: AppColors.kColor1,
                        // ignore: prefer_const_constructors
                        image: DecorationImage(
                          image: const NetworkImage(
                              'https://picsum.photos/250?image=9'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(65),
                        ),
                        border: Border.all(
                          color: AppColors.kColor1,
                          width: 6.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: currentHour >= 5 && currentHour <= 11
                                  ? AppLocalizations.of(context).goodMorning
                                  : currentHour > 11 && currentHour < 19
                                      ? AppLocalizations.of(context)
                                          .goodAfternoon
                                      : AppLocalizations.of(context)
                                          .goodEvening,
                              style: TextConfigs.kText24_1,
                              children: const <TextSpan>[
                                TextSpan(
                                  text: 'Hieu',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          // Add condition admin for account user
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.kGreen1,
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  'Administrator',
                                  style: TextConfigs.kText12W500Green1,
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              SvgPicture.asset("assets/icons/ic_admin.svg"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              // ignore: prefer_const_constructors
              SettingAppItem(
                backgroundColor: AppColors.kDarkBlue1,
                icon: "assets/icons/ic_post_moderation.svg",
                name: AppLocalizations.of(context).postModeration,
                colorItem: AppColors.kColor1,
                onTap: () {},
                visibility: true,
              ),
              SizedBox(
                height: 4.h,
              ),
              SettingAppItem(
                backgroundColor: AppColors.kColor1,
                icon: "assets/icons/ic_personal.svg",
                name: AppLocalizations.of(context).personalInfo,
                colorItem: AppColors.kBlackColor,
                onTap: () {},
                visibility: true,
              ),
              SizedBox(
                height: 4.h,
              ),
              SettingAppItem(
                backgroundColor: AppColors.kColor1,
                icon: "assets/icons/ic_changepwd.svg",
                name: AppLocalizations.of(context).changePwd,
                colorItem: AppColors.kBlackColor,
                onTap: () {},
                visibility: true,
              ),
              SizedBox(
                height: 32.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  AppLocalizations.of(context).setting,
                  style: TextConfigs.kText24_2,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SettingAppItem(
                backgroundColor: AppColors.kColor1,
                icon: "assets/icons/ic_language.svg",
                name: AppLocalizations.of(context).language,
                colorItem: AppColors.kBlackColor,
                onTap: () {},
                visibility: true,
              ),
              SizedBox(
                height: 4.h,
              ),
              SettingAppItem(
                backgroundColor: AppColors.kColor1,
                icon: "assets/icons/ic_aboutl.svg",
                name: AppLocalizations.of(context).aboutApp,
                colorItem: AppColors.kBlackColor,
                onTap: () {},
                visibility: true,
              ),
              SizedBox(
                height: 4.h,
              ),
              SettingAppItem(
                backgroundColor: AppColors.kColor1,
                icon: "assets/icons/ic_policy.svg",
                name: AppLocalizations.of(context).policy,
                colorItem: AppColors.kBlackColor,
                onTap: () {},
                visibility: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              SettingAppItem(
                backgroundColor: AppColors.kColor1,
                icon: "assets/icons/ic_logout.svg",
                name: AppLocalizations.of(context).logout,
                colorItem: AppColors.kBlackColor,
                onTap: () async {
                  await authService.signOut();
                  Navigator.pushAndRemoveUntil(
                      context, LoginPage.route(), (route) => false);
                },
                visibility: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // ignore: prefer_const_literals_to_create_immutables
//         children: [
//           const Text("HomeScreen"),
//           RoundedLinearButton(
//               text: "Log out",
//               press: () async {
//                 await authService.signOut();
//                 Navigator.pushAndRemoveUntil(
//                     context, LoginPage.route(), (route) => false);
//               },
//               textColor: Colors.black,
//               startColor: Colors.grey,
//               endColor: Colors.grey),
//           Text(AppLocalizations.of(context).helloWorld),
//           // ignore: prefer_const_constructors
//           SizedBox(
//             height: 10.0,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.read<LocaleProvider>().changeLocale();
//             },
//             child: Text(AppLocalizations.of(context).changeLaguage),
//           )
//         ],
//       ),
