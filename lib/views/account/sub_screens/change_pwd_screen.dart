import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          child: Container(),
        ),
      ),
    );
  }
}
