import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/color_config.dart';
import '../../../configs/text_config.dart';

class DiscoveryCard extends StatelessWidget {
  final String icon, title, subtitle;
  final VoidCallback onClick;
  const DiscoveryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onClick,
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w),
              width: 300.w,
              height: 400.h,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(icon),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 50.h),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextConfigs.kText16White.copyWith(
                              color: AppColors.kColor1.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 30.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: Text(
                            subtitle,
                            style: TextConfigs.kText16White.copyWith(
                                color: AppColors.kColor1, fontSize: 18.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              left: -10,
              top: -10,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "New to Explore",
                            style: TextConfigs.kText16White.copyWith(
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
