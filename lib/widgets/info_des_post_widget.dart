import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/widgets/tag_type_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/posts/destination_post.dart';

class InfoDestinationWidget extends StatelessWidget {
  final DestinationPost post;
  const InfoDestinationWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  post.postName,
                  style: TextConfigs.kTextHeader1.copyWith(
                    color: AppColors.kDarkBlue1,
                    fontWeight: FontWeight.w700,
                    fontSize: 39.sp,
                  ),
                ),
              ),
              TagTypeWidget(post: post),
            ],
          ),
          post.status == PostStatus.approve
              ? Row(
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
                      style: TextConfigs.kText16White.copyWith(
                        color: AppColors.kTextColor1,
                      ),
                    ),
                  ],
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_location.svg",
                  color: AppColors.kColor3,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Flexible(
                  child: Text(
                    TextConfigs().addressSetUp(
                      post.road!,
                      post.wards,
                      post.district,
                      post.province,
                    ),
                    style: TextConfigs.kText16Black.copyWith(
                      color: AppColors.kTextColor1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
