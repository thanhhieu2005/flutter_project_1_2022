import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RowTitleSeeAll extends StatelessWidget {
  final VoidCallback onTapSeeAll;
  final String title;
  const RowTitleSeeAll({
    Key? key,
    required this.onTapSeeAll,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextConfigs.kTextSubtitle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        // InkWell(
        //   onTap: onTapSeeAll,
        //   child: Text(
        //     AppLocalizations.of(context).seeAll,
        //     style: TextConfigs.kTextSubtitle.copyWith(
        //       fontWeight: FontWeight.w500,
        //       color: AppColors.kPrimaryColor,
        //       fontSize: 16.sp,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
