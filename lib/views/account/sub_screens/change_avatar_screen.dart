import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/account/setting_account_provider.dart';
import 'package:flutter_project_1/widgets/button/custom_back_button.dart';
import 'package:flutter_project_1/widgets/dialog/custom_dialog_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../configs/color_config.dart';

class ChangeAvatarScreen extends StatefulWidget {
  const ChangeAvatarScreen({Key? key}) : super(key: key);

  static const String nameRoute = '/change_avatar_screen';
  static Route route(RouteSettings settings) {
    final accountProvider = settings.arguments as SettingAccountProvider;
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => ChangeNotifierProvider<SettingAccountProvider>.value(
        value: accountProvider,
        child: const ChangeAvatarScreen(),
      ),
    );
  }

  @override
  State<ChangeAvatarScreen> createState() => _ChangeAvatarScreenState();
}

class _ChangeAvatarScreenState extends State<ChangeAvatarScreen> {
  void onSuccess() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomDialogWidget(
            assetsNamePng: "assets/images/check.png",
            content: AppLocalizations.of(context).contenAvatarSuccess,
            mainColor: AppColors.kLightGreen,
            title: AppLocalizations.of(context).titleAvatarSuccess,
          );
        });
  }

  void onFail() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomDialogWidget(
            assetsNamePng: "assets/images/error.png",
            content: AppLocalizations.of(context).contentAvatarFail,
            mainColor: AppColors.kLightRed,
            title: AppLocalizations.of(context).titleAvatarFail,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kBackgroundColor,
        title: Text(
          AppLocalizations.of(context).changeAvatar,
          style: TextConfigs.kText24_1.copyWith(
            color: AppColors.kColor0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leadingWidth: 48.w,
        leading: Consumer<SettingAccountProvider>(
            builder: (context, accountProvider, child) {
          return CustomBackButton(
            backgroundColor: AppColors.kBackgroundColor,
            onTapBack: () async {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName("/personal_info_screen"));
              await accountProvider.refreshFile();
            },
            iconColor: AppColors.kColor0,
            isCircleRounded: false,
          );
        }),
        actions: [
          Center(
            child: Consumer<SettingAccountProvider>(
                builder: (context, accountProvider, child) {
              return InkWell(
                splashColor: AppColors.kBackgroundColor,
                onTap: () {
                  // Navigator.of(context)
                  //     .popUntil(ModalRoute.withName("/personal_info_screen"));
                  accountProvider.saveAvatar(onSuccess, onFail);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    AppLocalizations.of(context).save,
                    style: TextConfigs.kTextSubtitleBold.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      body: Consumer<SettingAccountProvider>(
          builder: (context, accountProvider, child) {
        return ModalProgressHUD(
          progressIndicator: SpinKitThreeBounce(
            color: AppColors.kPrimaryColor,
            size: 32.h,
          ),
          inAsyncCall: accountProvider.isLoad,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<SettingAccountProvider>(
                      builder: (context, accountProvider, child) {
                    return accountProvider.avatar.path != ""
                        ? ClipOval(
                            child: Container(
                              height: 200.h,
                              width: 200.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadowConfig.kShadowGrey,
                                  ]),
                              child: Image.file(
                                File(
                                  accountProvider.avatar.path,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : ClipOval(
                            child: Container(
                              height: 200.h,
                              width: 200.h,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadowConfig.kShadowGrey,
                                ],
                                color: Colors.transparent,
                                border: Border.all(
                                    color: AppColors.kColor2, width: 0.5),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      accountProvider.getCurrUser().avatarUrl!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                  }),
                  SizedBox(height: 64.h),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Consumer<SettingAccountProvider>(
                        builder: (context, accountProvider, child) {
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.kColor0.withOpacity(0.3),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadowConfig.kShadowGrey,
                            ],
                          ),
                          child: Text(
                            AppLocalizations.of(context).chooseImage,
                            style: TextConfigs.kTextSubtitle.copyWith(
                              color: AppColors.kColor1,
                            ),
                          ),
                        ),
                        onTap: () {
                          accountProvider.selectFile();
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
