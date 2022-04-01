import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedMainButton extends StatelessWidget {
  final String text;
  final double height, width;
  final VoidCallback onTap;
  const RoundedMainButton({
    Key? key,
    required this.text,
    required this.height,
    required this.width,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.kDarkBlue1,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: AppColors.kColor1,
            ),
          ),
        ),
      ),
    );
  }
}
