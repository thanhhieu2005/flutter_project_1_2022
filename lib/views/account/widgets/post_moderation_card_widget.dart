import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostModerationCard extends StatelessWidget {
  final String firstImage, namePostModeration, location, date;
  // final String avatarSharer, nameSharer;
  final VoidCallback onTap;
  const PostModerationCard({
    Key? key,
    required this.firstImage,
    required this.namePostModeration,
    required this.location,
    required this.date,
    required this.onTap,
    // required this.avatarSharer,
    // required this.nameSharer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh / 4,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              top: 48.h,
              left: 8.w,
              right: 8.w,
              bottom: 4.h,
              child: Container(
                padding: EdgeInsets.only(top: 16.h, bottom: 16.h, right: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.kColor1,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadowConfig.kShadowGrey,
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // khoảng trắng bù cho hình
                    Container(
                      color: Colors.transparent,
                      width: 150.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NamePostModerationWidget(
                              namePostModeration: namePostModeration,
                            ),
                            SizedBox(height: 4.h),
                            InfoCardPostModeration(
                              assetIcon: "assets/icons/ic_location.svg",
                              content: location,
                            ),
                            SizedBox(height: 4.h),
                            InfoCardPostModeration(
                              assetIcon: "assets/icons/ic_aboutl.svg",
                              content: date,
                            ),
                            // SizedBox(height: 8.h),
                            // Row(
                            //   mainAxisSize: MainAxisSize.max,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       width: 24.h,
                            //       height: 24.h,
                            //       decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         image: DecorationImage(
                            //           fit: BoxFit.fill,
                            //           image: NetworkImage(avatarSharer),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 4.w,
                            //     ),
                            //     Flexible(
                            //       child: Text(
                            //         nameSharer,
                            //         style: TextConfigs.kText14White.copyWith(
                            //           color: AppColors.kTextGrey1,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              top: 8.h,
              left: 24.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  firstImage,
                  fit: BoxFit.fill,
                  width: 130.w,
                  height: 1.sh / 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCardPostModeration extends StatelessWidget {
  final String assetIcon, content;
  const InfoCardPostModeration({
    Key? key,
    required this.assetIcon,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          assetIcon,
          height: 14.h,
          width: 14.h,
          color: AppColors.kTextGrey1,
        ),
        SizedBox(
          width: 4.w,
        ),
        Flexible(
          child: Text(
            content,
            style: TextConfigs.kText14White.copyWith(
              color: AppColors.kTextGrey1,
            ),
          ),
        ),
      ],
    );
  }
}

class NamePostModerationWidget extends StatelessWidget {
  final String namePostModeration;
  const NamePostModerationWidget({
    Key? key,
    required this.namePostModeration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            namePostModeration,
            style: TextConfigs.kTextSubtitle.copyWith(
              color: AppColors.kDarkBlue1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 224, 198, 101),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            'Pending',
            style: TextConfigs.kText12W500Green1.copyWith(
              color: const Color.fromARGB(255, 224, 198, 101),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
