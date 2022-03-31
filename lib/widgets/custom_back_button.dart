import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final BuildContext currentWidgetContext;
  const CustomBackButton({
    Key? key,
    required this.currentWidgetContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(currentWidgetContext),
      child: Container(
        margin: EdgeInsets.only(
          left: 12.w,
        ),
        // height: 40.h,
        // width: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.kColor1,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset("assets/icons/ic_back.svg"),
        ),
      ),
    );
  }
}
