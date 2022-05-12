import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/edgeInset_config.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentWidget extends StatelessWidget {
  final VoidCallback onClick;
  final String countComment;
  const CommentWidget({
    Key? key,
    required this.onClick,
    required this.countComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsConfig.kOnlyLTR_20,
      // padding: EdgeInsets.all(10.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Comments',
            style: TextConfigs.kTextSubtitleBold.copyWith(
              color: AppColors.kDarkBlue1,
            ),
          ),
          InkWell(
            onTap: onClick,
            child: Row(
              children: [
                Text(
                  countComment,
                  style: TextConfigs.kTextSubtitleBold.copyWith(
                    color: AppColors.kDarkBlue1,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/ic_comment.svg",
                  color: AppColors.kDarkBlue1,
                  height: 32.h,
                  width: 32.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
