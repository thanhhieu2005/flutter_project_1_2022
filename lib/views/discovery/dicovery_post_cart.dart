import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/color_config.dart';
import '../../configs/text_config.dart';
import '../../models/posts/destination_post.dart';

class DiscoveryPostCard extends StatelessWidget {
  const DiscoveryPostCard({
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
        height: 90.h,
        width: 250.w,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadowConfig.kShadowGrey,
            ]),
        child: Stack(
          children: [
            Container(
              // height: 60.h,
              constraints: BoxConstraints(minWidth: 120.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(post.images.first),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: 0.7,
              duration: const Duration(seconds: 0),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstOut,
                child: Container(
                  width: 250.w,
                  height: 300.h,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
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
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    post.postName,
                    style: TextConfigs.kText16White.copyWith(
                        color: AppColors.kColor1.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 26.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
