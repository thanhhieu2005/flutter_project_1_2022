import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/account/account_provider.dart';
import 'package:flutter_project_1/views/account/sub_screens/avatar_user_widget.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_project_1/widgets/custom_form_field.dart';
import 'package:flutter_project_1/widgets/rounded_main_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const String nameRoute = '/personal_info_screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<AccountProvider>(
        create: (_) => AccountProvider(),
        child: const PersonalInfoScreen(),
      ),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountProvider = context.read<AccountProvider>();
    var infoUser = accountProvider.getCurrUser();
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            floating: true,
            backgroundColor: AppColors.kBackgroundColor,
            leadingWidth: 48.w,
            leading: Align(
              alignment: Alignment.centerLeft,
              child: CustomBackButton(
                backgroundColor: AppColors.kColor1,
                iconColor: AppColors.kColor0,
                currentWidgetContext: context,
              ),
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
        body: SingleChildScrollView(
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
                Text(
                  AppLocalizations.of(context).photo,
                  style: TextConfigs.kTextSubtitle,
                ),
                Center(
                  child: AvatarUserWidget(
                    height: 100.h,
                    width: 100.h,
                    linkImage: infoUser.avatarUrl!,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context).uploadPhoto,
                    style: TextConfigs.kTextBody1KPrimaryBold,
                  ),
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
                ),
                SizedBox(
                  height: 54.h,
                ),
                Center(
                  child: RoundedMainButton(
                    text: AppLocalizations.of(context).save,
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
