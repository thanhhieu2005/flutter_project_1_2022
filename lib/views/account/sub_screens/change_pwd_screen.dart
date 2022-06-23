// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/account/setting_account_provider.dart';
import 'package:flutter_project_1/views/account/widgets/confirm_pwd_field.dart';
import 'package:flutter_project_1/views/account/widgets/cur_pwd_field.dart';
import 'package:flutter_project_1/views/account/widgets/new_pwd_field.dart';
import 'package:flutter_project_1/widgets/button/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../widgets/button/rounded_main_button.dart';
import '../../../widgets/dialog/custom_dialog.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String nameRoute = '/change_pwd_screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ChangePasswordScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const ChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingAccountProvider>(
      builder: (context, provider, child) {
        return ModalProgressHUD(
          progressIndicator: SpinKitThreeBounce(
            color: AppColors.kPrimaryColor,
            size: 32.h,
          ),
          inAsyncCall: provider.isLoadChangePwd,
          child: Scaffold(
            backgroundColor: AppColors.kBackgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.h),
              child: AppBar(
                elevation: 0,
                backgroundColor: AppColors.kBackgroundColor,
                automaticallyImplyLeading: false,
                leadingWidth: 48.w,
                leading: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 12.h,
                    ),
                    child: CustomBackButton(
                      onTapBack: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: AppColors.kColor1,
                      iconColor: AppColors.kColor0,
                      isCircleRounded: false,
                    ),
                  ),
                ),
                flexibleSpace: SafeArea(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 12.w,
                        top: 12.h,
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
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 54.h,
                      ),
                      Text(
                        AppLocalizations.of(context).currPwd,
                        style: TextConfigs.kTextSubtitleBold,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CurrentPasswordField(
                        controller: provider.currentPwdController,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        AppLocalizations.of(context).newPwd,
                        style: TextConfigs.kTextSubtitleBold,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      NewPasswordField(
                        controller: provider.newPwdController,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        AppLocalizations.of(context).confirmPwd,
                        style: TextConfigs.kTextSubtitleBold,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      ConfirmPasswordField(
                        confirmPwdController: provider.confirmPwdController,
                        newPassword: provider.confirmPwdController.text,
                        onChanged: (String value) {},
                      ),
                      SizedBox(
                        height: 54.h,
                      ),
                      Center(
                        child: RoundedMainButton(
                          text: AppLocalizations.of(context).save,
                          height: 56.h,
                          width: 240.w,
                          onTap: () async {
                            try {
                              EasyLoading.show(
                                  status: "Loading",
                                  indicator: SpinKitThreeBounce(
                                    color: AppColors.kPrimaryColor,
                                    size: 32.h,
                                  ),
                                  dismissOnTap: false,
                                  maskType: EasyLoadingMaskType.custom);
                              await provider.changePassword();
                              EasyLoading.showSuccess("Success");
                              Navigator.pop(context);
                            } catch (err) {
                              showDialog(
                                context: context,
                                builder: (context) => const CustomDialog(
                                  title: "Failed",
                                  description:
                                      "Password is not validate, Please try again!",
                                  image: 'cancel.png',
                                  hasDescription: true,
                                ),
                              );
                            }
                            EasyLoading.dismiss(animation: true);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
