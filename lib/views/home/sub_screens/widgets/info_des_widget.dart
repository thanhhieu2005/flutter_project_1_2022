import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../configs/edgeInset_config.dart';

class InfoDestinationWidget extends StatelessWidget {
  final String postName, province, district;
  final double rating;
  final String? road;
  final int type;
  const InfoDestinationWidget({
    Key? key,
    required this.postName,
    required this.province,
    required this.district,
    required this.rating,
    this.road,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsConfig.kOnlyLTR_20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postName,
                style: TextConfigs.kText24_1.copyWith(
                  color: AppColors.kColor0,
                  fontWeight: FontWeight.w700,
                  fontSize: 32.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: rating,
                    itemCount: 5,
                    itemSize: 24.w,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: AppColors.kColor4,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '(' + rating.toString() + ')',
                    style: TextConfigs.kText16_1.copyWith(
                      color: AppColors.kTextColor1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/ic_location.svg",
                    color: AppColors.kDarkBlue1,
                  ),
                  Text(
                    road == ''
                        ? district + ', ' + province
                        : road! + ', ' + district + ', ' + province,
                    style: TextConfigs.kText16Black.copyWith(
                      color: AppColors.kTextColor1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kColor1,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.kLightBlue1,
                    blurRadius: 1,
                    offset: Offset(0, 0.5),
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type == 1
                      ? 'Beach'
                      : type == 2
                          ? 'Mountain'
                          : type == 3
                              ? 'Island'
                              : 'City',
                  style: TextConfigs.kText14Black,
                ),
                SizedBox(
                  width: 8.w,
                ),
                SvgPicture.asset(
                  type == 1
                      ? 'assets/icons/ic_beach.svg'
                      : type == 2
                          ? 'assets/icons/ic_mountain.svg'
                          : type == 3
                              ? 'assets/icons/ic_island.svg'
                              : 'assets/icons/ic_city.svg',
                  width: 24.w,
                  height: 24.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
