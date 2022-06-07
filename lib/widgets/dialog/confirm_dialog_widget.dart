import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialogWidget extends StatelessWidget {
  final String assetsNamePng, title, content;
  final Color confirmColorButton;
  final VoidCallback onTapConfirm;
  const ConfirmDialogWidget({
    Key? key,
    required this.assetsNamePng,
    required this.title,
    required this.content,
    required this.confirmColorButton,
    required this.onTapConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      titlePadding: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
      title: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetsNamePng,
              height: 80.h,
              width: 80.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Center(
              child: Text(
                title,
                style: TextConfigs.kTextSubtitle
                    .copyWith(color: AppColors.kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20, 24.0, 12),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              content,
              style: TextConfigs.kText16Black,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.only(bottom: 16.h),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 1.sw / 3.5,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: AppColors.kLightRed,
            ),
            child: Center(
              child: Text(
                'Cancel',
                style: TextConfigs.kTextSubtitle
                    .copyWith(color: AppColors.kColor1),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTapConfirm,
          child: Container(
            width: 1.sw / 3.5,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: confirmColorButton,
            ),
            child: Center(
              child: Text(
                'OK',
                style: TextConfigs.kTextSubtitle
                    .copyWith(color: AppColors.kColor1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
