import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../configs/color_config.dart';
import '../configs/text_config.dart';
import '../models/posts/destination_post.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.post,
    required this.onClick,
  }) : super(key: key);

  final DestinationPost post;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        constraints: BoxConstraints(minHeight: 120.h),
        margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
        height: 90.h,
        width: 1.sw,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadowConfig.kShadowGrey,
            ]),
        child: Stack(
          children: [
            Positioned(
              right: 16.w,
              // top: 10.h,
              child: Container(
                height: 40.h,
                width: 64.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: AppColors.kColor4,
                  // boxShadow: [
                  //   BoxShadowConfig.kShadowGrey,
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      post.rating.toString(),
                      style: TextConfigs.kTextSubtitle.copyWith(
                        color: AppColors.kColor1,
                      ),
                    ),
                    SvgPicture.asset("assets/icons/ic_star.svg"),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    // height: 60.h,
                    constraints: BoxConstraints(maxWidth: 120.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(post.images.first),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            post.postName,
                            style: TextConfigs.kTextSubtitle.copyWith(
                              color: AppColors.kColor0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Flexible(
                          child: Text(
                            post.district + ', ' + post.province,
                            style: TextConfigs.kText14Black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
