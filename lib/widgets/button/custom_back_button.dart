import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final void Function()? onTapBack;
  final Color backgroundColor, iconColor;
  final double? height, width;
  final bool isCircleRounded;
  const CustomBackButton({
    Key? key,
    required this.onTapBack,
    required this.backgroundColor,
    required this.iconColor,
    this.height,
    this.width,
    required this.isCircleRounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapBack,
      child: Container(
        margin: EdgeInsets.only(
          left: 12.w,
        ),
        height: height,
        width: width,
        decoration: isCircleRounded
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              )
            : null,
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/ic_back.svg",
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
