import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DevelopingDiaglog extends StatelessWidget {
  const DevelopingDiaglog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber,
            color: AppColors.kColor4,
            size: 24.sp,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            'Notification',
            style: TextConfigs.kText24_2,
          ),
        ],
      ),
      content: Text(
        'The feature is developing, please try later!',
        textAlign: TextAlign.center,
        style: TextConfigs.kText16BoldKprimary.copyWith(
          fontSize: 24.sp,
        ),
      ),
      // contentPadding:
      //     EdgeInsets.only(top: 16.h),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 32.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.kDarkBlue1,
            ),
            child: Text(
              'Close',
              style: TextConfigs.kText14White.copyWith(fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }
}
