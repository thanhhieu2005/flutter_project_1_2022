import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/edgeInset_config.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DesPostModerationWidget extends StatelessWidget {
  final String content;
  const DesPostModerationWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.h,
      margin: EdgeInsetsConfig.kOnlyLTR_20,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: AppColors.kColor5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: AppColors.kLightBlue5,
            ),
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_aboutl.svg",
                    color: AppColors.kDarkBlue1,
                  ),
                  Text(
                    AppLocalizations.of(context).description,
                    style: TextConfigs.kTextSubtitleBold.copyWith(
                      color: AppColors.kDarkBlue1,
                    ),
                  ),
                  const Text(
                    '       ', // blank to center
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.h),
            child: Text(
              content,
              style: TextConfigs.kText16Black,
            ),
          ),
        ],
      ),
    );
  }
}
