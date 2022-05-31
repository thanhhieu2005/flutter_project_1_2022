import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/edgeInset_config.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SharerPostWidget extends StatelessWidget {
  final VoidCallback onClick;
  final VatractionUser sharer;
  const SharerPostWidget({
    Key? key,
    required this.onClick,
    required this.sharer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsConfig.kOnlyLTR_20.copyWith(
        bottom: 20.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: AppColors.kColor5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: AppColors.kLightBlue5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_post_moderation.svg",
                  color: AppColors.kDarkBlue1,
                  height: 24.h,
                  width: 24.h,
                ),
                SizedBox(
                  width: 8.w,
                ),
                InkWell(
                  onTap: onClick,
                  child: Text(
                    AppLocalizations.of(context).sharer,
                    style: TextConfigs.kText16Black.copyWith(
                      color: AppColors.kDarkBlue1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Text(
              sharer.userName.toString(),
              style: TextConfigs.kText16Black.copyWith(
                color: AppColors.kColor0,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
