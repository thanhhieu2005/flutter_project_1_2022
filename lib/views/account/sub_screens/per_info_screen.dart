import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/account/account_provider.dart';
import 'package:flutter_project_1/views/account/sub_screens/change_avatar_screen.dart';
import 'package:flutter_project_1/views/account/widgets/avatar_user_widget.dart';
import 'package:flutter_project_1/views/account/widgets/bottom_sheet_uploadphoto.dart';
import 'package:flutter_project_1/widgets/button/custom_back_button.dart';
import 'package:flutter_project_1/widgets/dialog/custom_dialog_widget.dart';
import 'package:flutter_project_1/widgets/text_field/custom_form_field.dart';
import 'package:flutter_project_1/widgets/dialog/open_dialog.dart';
import 'package:flutter_project_1/widgets/button/rounded_main_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const String nameRoute = '/personal_info_screen';
  static Route route(RouteSettings settings) {
    final accountProvider = settings.arguments as AccountProvider;
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => ChangeNotifierProvider<AccountProvider>.value(
        value: accountProvider,
        child: const PersonalInfoScreen(),
      ),
    );
  }

  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onFail() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const CustomDialogWidget(
              assetsNamePng: "assets/images/error.png",
              content: 'You need to check your Name, please!',
              mainColor: AppColors.kLightRed,
              title: 'Oh...No!',
            );
          });
    }

    void onSuccess() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const CustomDialogWidget(
              assetsNamePng: "assets/images/check.png",
              content: 'Your info has been change!',
              mainColor: AppColors.kLightGreen,
              title: 'Amazing!',
            );
          });
    }

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 0,
            floating: true,
            backgroundColor: AppColors.kBackgroundColor,
            leadingWidth: 48.w,
            leading: Align(
              alignment: Alignment.centerLeft,
              child: Consumer<AccountProvider>(
                  builder: (context, accountProvider, child) {
                return CustomBackButton(
                  backgroundColor: AppColors.kColor1,
                  iconColor: AppColors.kColor0,
                  onTapBack: () async {
                    Navigator.pop(context);
                    await accountProvider.refeshInput();
                  },
                  isCircleRounded: false,
                );
              }),
            ),
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                AppLocalizations.of(context).account,
                style: TextConfigs.kTextHeader1,
              ),
            ),
          ),
        ],
        body: Consumer<AccountProvider>(
            builder: (context, accountProvider, child) {
          return ModalProgressHUD(
            progressIndicator: SpinKitThreeBounce(
              color: AppColors.kPrimaryColor,
              size: 32.h,
            ),
            inAsyncCall: accountProvider.isLoad,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                  top: 10.h,
                  // vertical: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   AppLocalizations.of(context).photo,
                    //   style: TextConfigs.kTextSubtitle,
                    // ),
                    Center(
                      child: AvatarUserWidget(
                        height: 100.h,
                        width: 100.h,
                        linkImage: accountProvider.getCurrUser().avatarUrl!,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    InkWell(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).uploadPhoto,
                          style: TextConfigs.kTextBody1KPrimaryBold,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return BottomSheetUploadPhoto(
                              onClick: () {
                                Navigator.pushNamed(
                                  context,
                                  ChangeAvatarScreen.nameRoute,
                                  arguments: accountProvider,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    // Thay đổi Tên người dùng
                    Text(
                      AppLocalizations.of(context).name,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormFieldCustom(
                      inputType: TextInputType.name,
                      controller: accountProvider.userNameController,
                      readOnly: false,
                      requiredText: true,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Thay đổi email
                    Text(
                      AppLocalizations.of(context).email,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormFieldCustom(
                      inputType: TextInputType.emailAddress,
                      controller: accountProvider.emailController,
                      readOnly: true,
                      requiredText: false,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Thay đổi số điện thoại
                    Text(
                      AppLocalizations.of(context).phoneNum,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormFieldCustom(
                      inputType: TextInputType.phone,
                      controller: accountProvider.phoneNumController,
                      readOnly: false,
                      requiredText: false,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Thay đổi ngày sinh
                    Text(
                      AppLocalizations.of(context).dOB,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormFieldCustom(
                      inputType: TextInputType.datetime,
                      controller: accountProvider.dOBController,
                      readOnly: false,
                      requiredText: false,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Thay đổi địa chỉ
                    Text(
                      AppLocalizations.of(context).address,
                      style: TextConfigs.kTextSubtitle,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormFieldCustom(
                      inputType: TextInputType.streetAddress,
                      controller: accountProvider.addressController,
                      readOnly: false,
                      requiredText: false,
                    ),
                    SizedBox(
                      height: 54.h,
                    ),
                    Center(
                      child: Consumer<AccountProvider>(
                          builder: (context, provider, child) {
                        return RoundedMainButton(
                          text: AppLocalizations.of(context).save,
                          height: 56.h,
                          width: 240.w,
                          onTap: () async {
                            await provider.updateInfoUser(onSuccess, onFail);
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
      ),
    );
  }
}
