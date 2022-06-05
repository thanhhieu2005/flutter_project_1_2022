import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogWidget extends StatelessWidget {
  final String assetsNamePng, title, content;
  final Color mainColor;
  const CustomDialogWidget({
    Key? key,
    required this.assetsNamePng,
    required this.title,
    required this.content,
    required this.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetsNamePng,
              height: 80.h,
              width: 80.h,
            ),
            Text(
              title,
              style: TextConfigs.kTextSubtitle.copyWith(color: mainColor),
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
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
            ),
            child: Text(
              'OK',
              style:
                  TextConfigs.kTextSubtitle.copyWith(color: AppColors.kColor1),
            ),
          ),
        ),
      ],
    );
  }
}
