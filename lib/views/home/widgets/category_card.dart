import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/color_config.dart';
import '../../../configs/text_config.dart';

class CategoryCard extends StatelessWidget {
  final String icon, title;
  final VoidCallback onClick;
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 4.h,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              width: 40.w,
              height: 40.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              title,
              style: TextConfigs.kText16White.copyWith(
                color: AppColors.kDarkBlue1,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
