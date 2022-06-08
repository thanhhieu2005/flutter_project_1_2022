import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemPostModerationWidget extends StatelessWidget {
  final String? avatar;
  final String content;
  final String title;
  final bool hasAvatar;
  const ItemPostModerationWidget({
    Key? key,
    required this.content,
    this.avatar,
    required this.hasAvatar,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.kGreyLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 1.sw / 2.9,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.kLightBlue5,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_location.svg",
                  color: AppColors.kDarkBlue1,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  title,
                  style: TextConfigs.kText16Black.copyWith(
                    color: AppColors.kDarkBlue1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.kGreyLight,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    hasAvatar
                        ? Container(
                            width: 24.h,
                            height: 24.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(avatar!),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      content,
                      style: TextConfigs.kText16Black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
