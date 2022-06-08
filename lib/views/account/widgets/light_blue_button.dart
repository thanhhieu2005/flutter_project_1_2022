import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LightBlueButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color textColor;
  const LightBlueButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 24.w,
        ),
        decoration: BoxDecoration(
            color: AppColors.kLightBlue5,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadowConfig.kLight5Button,
            ]),
        child: Text(
          text,
          style: TextConfigs.kTextHeader1.copyWith(
            color: textColor,
            fontSize: 28.sp,
          ),
        ),
      ),
    );
  }
}
