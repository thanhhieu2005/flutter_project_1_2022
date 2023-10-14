import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/color_config.dart';

class NotifyButton extends StatelessWidget {
  final VoidCallback onClick;
  const NotifyButton({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onClick,
        child: Container(
          // height: 48.h,
          // width: 48.w,
          padding: EdgeInsets.all(4.r),
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
            child: Badge(
              // showBadge: , /* Để hàm kiểm tra có thông báo */
              // animationType: BadgeAnimationType.slide,
              // label: Container(
              //   padding: EdgeInsets.all(4.r),
              //   decoration: const BoxDecoration(
              //       shape: BoxShape.circle, color: AppColors.kColor3,),
              // ), 
              isLabelVisible: false,
              child: SvgPicture.asset(
                "assets/icons/ic_notification.svg",
                height: 28.h,
                width: 28.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
