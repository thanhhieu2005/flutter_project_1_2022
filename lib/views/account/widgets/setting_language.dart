import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingLanguage extends StatelessWidget {
  final Color backgroundColor;
  final String icon;
  final String name;
  final String currentLanguage;
  final Color colorItem;
  final VoidCallback onTap;
  final bool visibility;
  const SettingLanguage({
    Key? key,
    required this.backgroundColor,
    required this.colorItem,
    required this.icon,
    required this.name,
    required this.onTap,
    required this.visibility,
    required this.currentLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        height: 48.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    color: colorItem,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: colorItem,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    currentLanguage,
                    style: TextConfigs.kText16Black,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Visibility(
                    visible: visibility,
                    child: SvgPicture.asset(
                      "assets/icons/ic_right.svg",
                      color: colorItem,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
