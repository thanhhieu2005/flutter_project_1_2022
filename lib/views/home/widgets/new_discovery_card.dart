import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewDiscoveryCard extends StatelessWidget {
  final DestinationPost post;
  final VoidCallback onClick;
  const NewDiscoveryCard({
    Key? key,
    required this.onClick,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
            height: 160.h,
            width: 160.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(post.images.first),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: AnimatedOpacity(
              opacity: 1,
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
                  height: 70.h,
                  width: 160.w,
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
          ),
          Positioned(
            bottom: 15,
            child: Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      post.postName,
                      style: TextConfigs.kTextSubtitle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.kColor1),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Flexible(
                    child: Text(
                      post.province,
                      style: TextConfigs.kText16Black.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.kColor1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
