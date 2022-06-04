import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/account/account_provider.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../configs/color_config.dart';

class ChangeAvatarScreen extends StatefulWidget {
  const ChangeAvatarScreen({Key? key}) : super(key: key);

  static const String nameRoute = '/change_avatar_screen';
  static Route route(RouteSettings settings) {
    final accountProvider = settings.arguments as AccountProvider;
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => ChangeNotifierProvider<AccountProvider>.value(
        value: accountProvider,
        child: const ChangeAvatarScreen(),
      ),
    );
  }

  @override
  State<ChangeAvatarScreen> createState() => _ChangeAvatarScreenState();
}

class _ChangeAvatarScreenState extends State<ChangeAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kBackgroundColor,
        title: Text(
          'Change Avatar',
          style: TextConfigs.kText24_1.copyWith(
            color: AppColors.kColor0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leadingWidth: 48.w,
        leading: Consumer<AccountProvider>(
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
            child: Consumer<AccountProvider>(
                builder: (context, accountProvider, child) {
              return InkWell(
                splashColor: AppColors.kBackgroundColor,
                onTap: () async {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName("/personal_info_screen"));
                  await accountProvider.saveAvatar();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Save',
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<AccountProvider>(
                  builder: (context, accountProvider, child) {
                return accountProvider.avatar.path != ""
                    ? Container(
                        constraints: BoxConstraints(
                          minHeight: 120.h,
                          maxHeight: 200.h,
                          minWidth: 120.w,
                          maxWidth: 200.w,
                        ),
                        // height: 120.h,
                        // width: 120.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Image.file(
                          File(
                            accountProvider.avatar.path,
                          ),
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        constraints: BoxConstraints(
                          minHeight: 120.h,
                          maxHeight: 200.h,
                          minWidth: 120.w,
                          maxWidth: 200.w,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                          image: DecorationImage(
                            image: NetworkImage(
                                accountProvider.getCurrUser().avatarUrl!),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
              }),
              SizedBox(height: 64.h),
              Align(
                alignment: Alignment.topCenter,
                child: Consumer<AccountProvider>(
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
                        boxShadow: const [
                          BoxShadowConfig.kShadowGrey,
                        ],
                      ),
                      child: Text(
                        'Choose Image',
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
  }
}
