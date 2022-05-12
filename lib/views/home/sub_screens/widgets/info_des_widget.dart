import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../configs/EdgeInset_config.dart';

class InfoDestinationWidget extends StatelessWidget {
  final String locationDiscovery, address;
  final double rating;
  const InfoDestinationWidget({
    Key? key,
    required this.locationDiscovery,
    required this.address,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsConfig.kOnlyLTR_20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locationDiscovery,
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
                address,
                style: TextConfigs.kText16Black.copyWith(
                  color: AppColors.kTextColor1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
