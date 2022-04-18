// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/views/account/widgets/confirm_pwd_field.dart';
import 'package:flutter_project_1/views/account/widgets/cur_pwd_field.dart';
import 'package:flutter_project_1/views/account/widgets/new_pwd_field.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/rounded_main_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String nameRoute = '/change_pwd_screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ChangePasswordScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPwd = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.kBackgroundColor,
          automaticallyImplyLeading: false,
          leadingWidth: 48.w,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: CustomBackButton(
              currentWidgetContext: context,
            ),
          ),
          flexibleSpace: SafeArea(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 8.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context).change,
                      style: TextConfigs.kTextHeader1,
                    ),
                    Text(
                      AppLocalizations.of(context).yourPwd,
                      style: TextConfigs.kTextHeader1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 54.h,
                ),
                Text(
                  'Current Password',
                  style: TextConfigs.kTextSubtitleBold,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CurrentPasswordField(
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'New Password',
                  style: TextConfigs.kTextSubtitleBold,
                ),
                SizedBox(
                  height: 8.h,
                ),
                NewPasswordField(
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'Confirm New Password',
                  style: TextConfigs.kTextSubtitleBold,
                ),
                SizedBox(
                  height: 8.h,
                ),
                ConfirmPasswordField(
                  newPassword: newPwd.text,
                  onChanged: (String value) {},
                ),
                SizedBox(
                  height: 54.h,
                ),
                Center(
                  child: RoundedMainButton(
                    text: 'Save',
                    height: 56.h,
                    width: 240.w,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
