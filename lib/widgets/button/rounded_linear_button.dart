import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/color_config.dart';

class RoundedLinearButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final bool isAllCap;
  final bool isTextBool;
  final Color color, textColor, startColor, endColor;
  const RoundedLinearButton({
    Key? key,
    required this.text,
    required this.press(),
    this.isAllCap = true,
    this.color = AppColors.kPrimaryColor,
    this.isTextBool = false,
    required this.textColor,
    required this.startColor,
    required this.endColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 20.w),
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            endColor,
            startColor,
          ]),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            isAllCap ? text.toUpperCase() : text,
            style: isTextBool
                ? TextStyle(
                    fontSize: 20.sp,
                    color: textColor,
                    fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 20.sp, color: textColor),
          ),
        ),
      ),
    );
  }
}
