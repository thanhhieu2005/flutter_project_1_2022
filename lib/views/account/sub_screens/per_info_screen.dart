import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/views/account/account_screen.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_project_1/widgets/custom_form_field.dart';
import 'package:flutter_project_1/widgets/rounded_main_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const String nameRoute = '/personal_info_screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const PersonalInfoScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kBackgroundColor,
        leadingWidth: 48.w,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: CustomBackButton(
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
      backgroundColor: AppColors.kBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CustomBackButton(
                //       currentWidgetContext: context,
                //     ),
                //     Text(
                //       AppLocalizations.of(context).account,
                //       style: TextConfigs.kTextHeader1,
                //     ),
                //   ],
                // ),

                Text(
                  'Photo',
                  style: TextConfigs.kTextSubtitle,
                ),
                Center(
                  child: AvatarUserWidget(
                    height: 100.h,
                    width: 100.h,
                    linkImage: 'https://picsum.photos/250?image=9',
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Center(
                  child: Text(
                    'Upload Photo',
                    style: TextConfigs.kTextBody1KPrimaryBold,
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                // Thay đổi Tên người dùng
                Text(
                  'Name',
                  style: TextConfigs.kTextSubtitle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const TextFormFieldCustom(
                  inputType: TextInputType.name,
                ),
                SizedBox(
                  height: 16.h,
                ),
                // Thay đổi email
                Text(
                  'Email',
                  style: TextConfigs.kTextSubtitle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const TextFormFieldCustom(
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16.h,
                ),
                // Thay đổi số điện thoại
                Text(
                  'Phone Number',
                  style: TextConfigs.kTextSubtitle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const TextFormFieldCustom(
                  inputType: TextInputType.phone,
                ),
                SizedBox(
                  height: 16.h,
                ),
                // Thay đổi ngày sinh
                Text(
                  'Date of Birth',
                  style: TextConfigs.kTextSubtitle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const TextFormFieldCustom(
                  inputType: TextInputType.datetime,
                ),
                SizedBox(
                  height: 16.h,
                ),
                // Thay đổi địa chỉ
                Text(
                  'Address',
                  style: TextConfigs.kTextSubtitle,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const TextFormFieldCustom(
                  inputType: TextInputType.streetAddress,
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
