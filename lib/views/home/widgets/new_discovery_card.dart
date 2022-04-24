import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewDiscoveryCard extends StatelessWidget {
  final String linkImage, titleCard, address, pointEvaluation;

  final VoidCallback onClick;
  const NewDiscoveryCard({
    Key? key,
    required this.linkImage,
    required this.titleCard,
    required this.address,
    required this.pointEvaluation,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 200.h,
        width: 250.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(linkImage),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 15.h,
              right: 10.w,
              left: 10.w,
              child: Container(
                height: 64.h,
                width: 180.w,
                decoration: const BoxDecoration(
                  color: AppColors.kColor1,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          titleCard,
                          style: TextConfigs.kTextSubtitle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Expanded(
                        child: Text(
                          address,
                          style: TextConfigs.kText16Black.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60.h,
              right: 20.w,
              child: Container(
                height: 24.h,
                width: 64.w,
                decoration: BoxDecoration(
                  color: AppColors.kColor1,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_star.svg",
                        color: AppColors.kColor4,
                      ),
                      Text(
                        pointEvaluation,
                        style: TextConfigs.kText12W500Green1.copyWith(
                          color: AppColors.kColor0,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
