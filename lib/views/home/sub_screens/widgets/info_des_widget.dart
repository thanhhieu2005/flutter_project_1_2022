import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../configs/edgeInset_config.dart';
import '../../../../models/posts/post.dart';

class InfoDestinationWidget extends StatelessWidget {
  final Post post;
  const InfoDestinationWidget({
    Key? key,
    required this.post,
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
                post.postName,
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
                    rating: post.rating,
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
                    '(' + post.rating.toString() + ')',
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
                    post.road == ''
                        ? post.district + ', ' + post.province
                        : post.road! +
                            ', ' +
                            post.district +
                            ', ' +
                            post.province,
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
                  post.type == PostType.beach
                      ? AppLocalizations.of(context).beach
                      : post.type == PostType.mountain
                          ? AppLocalizations.of(context).mountain
                          : post.type == PostType.island
                              ? AppLocalizations.of(context).island
                              : AppLocalizations.of(context).city,
                  style: TextConfigs.kText14Black,
                ),
                SizedBox(
                  width: 8.w,
                ),
                SvgPicture.asset(
                  post.type == PostType.beach
                      ? 'assets/icons/ic_beach.svg'
                      : post.type == PostType.mountain
                          ? 'assets/icons/ic_mountain.svg'
                          : post.type == PostType.island
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
