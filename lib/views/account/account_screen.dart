import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/view_models/locale_provider.dart';
import 'package:flutter_project_1/views/account/sub_screens/avatar_user_widget.dart';
import 'package:flutter_project_1/views/account/sub_screens/change_pwd_screen.dart';
import 'package:flutter_project_1/views/account/sub_screens/per_info_screen.dart';
import 'package:flutter_project_1/views/account/widgets/setting_app_item.dart';
import 'package:flutter_project_1/views/account/widgets/setting_language.dart';
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
    final currentUser = localCurrentUser;
    var displayName = currentUser.userName!.split(" ");
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
                    AvatarUserWidget(
                      height: 80.h,
                      width: 80.h,
                      linkImage: currentUser.avatarUrl!,
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
                              children: <TextSpan>[
                                TextSpan(
                                  text: displayName.last,
                                  style: TextConfigs.kText24_1
                                      .copyWith(fontWeight: FontWeight.w700),
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
                                    color: AppColors.kColor6,
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
                onTap: () {
                  Navigator.pushNamed(context, PersonalInfoScreen.nameRoute);
                },
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
                onTap: () => Navigator.pushNamed(
                    context, ChangePasswordScreen.nameRoute),
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
              SettingLanguage(
                backgroundColor: AppColors.kColor1,
                icon: "assets/icons/ic_language.svg",
                name: AppLocalizations.of(context).language,
                colorItem: AppColors.kBlackColor,
                onTap: () {
                  context.read<LocaleProvider>().changeLocale();
                },
                visibility: true,
                currentLanguage: AppLocalizations.of(context).currentLanguage,
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
