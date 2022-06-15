import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralPostCard extends StatelessWidget {
  final bool isModeration;
  final String firstImage, namePostModeration, location, date;
  final bool isPending;
  final double? rating;

  // final String avatarSharer, nameSharer;
  final VoidCallback onTap;
  const GeneralPostCard({
    Key? key,
    required this.firstImage,
    required this.namePostModeration,
    required this.location,
    required this.date,
    required this.onTap,
    required this.isPending,
    this.isModeration = true,
    this.rating,
    // required this.avatarSharer,
    // required this.nameSharer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh / 3.8,
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
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 12.h,
                      bottom: 12.h,
                      right: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: isModeration
                          ? AppColors.kColor1
                          : AppColors.kDarkGrey,
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
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NameGeneralPostCardWidget(
                                    namePostModeration: namePostModeration,
                                    isPending: isPending,
                                  ),
                                  SizedBox(height: 4.h),
                                  isPending
                                      ? InfoGeneralPostCard(
                                          assetIcon:
                                              "assets/icons/ic_aboutl.svg",
                                          content: date,
                                          isPending: isPending,
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                RatingBarIndicator(
                                                  rating:
                                                      isPending ? 0 : rating!,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          const Icon(
                                                    Icons.star,
                                                    color: AppColors.kColor4,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 18.h,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(
                                              rating.toString(),
                                              style: TextConfigs.kText14Black
                                                  .copyWith(
                                                color: AppColors.kTextGrey,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(height: 4.h),
                                  InfoGeneralPostCard(
                                    assetIcon: "assets/icons/ic_location.svg",
                                    content: location,
                                    isPending: isPending,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: -5,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(left: 40.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: AppColors.kTextLightPrimary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadowConfig.kShadowGrey,
                          ],
                        ),
                        child: Text(
                          "Tourist Attraction",
                          style: TextConfigs.kText12W500Green1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
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

class InfoGeneralPostCard extends StatelessWidget {
  final String assetIcon, content;
  final bool isPending;
  const InfoGeneralPostCard({
    Key? key,
    required this.assetIcon,
    required this.content,
    required this.isPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeAsset = 13.h;
    final sizeAsset2 = 16.h;
    final sizeText = 13.sp;
    final sizeText2 = 16.sp;
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          assetIcon,
          height: isPending ? sizeAsset : sizeAsset2,
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
              fontSize: isPending ? sizeText : sizeText2,
            ),
          ),
        ),
      ],
    );
  }
}

class InfoRatingPostWidget extends StatelessWidget {
  const InfoRatingPostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NameGeneralPostCardWidget extends StatelessWidget {
  final String namePostModeration;
  final bool isPending;
  const NameGeneralPostCardWidget({
    Key? key,
    required this.namePostModeration,
    required this.isPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isPending
        ? Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  namePostModeration,
                  style: TextConfigs.kTextSubtitle.copyWith(
                      color: AppColors.kDarkBlue1,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp),
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
                  AppLocalizations.of(context).pending,
                  style: TextConfigs.kText12W500Green1.copyWith(
                    color: Color.fromARGB(255, 182, 160, 81),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  namePostModeration,
                  style: TextConfigs.kTextSubtitle.copyWith(
                    color: AppColors.kDarkBlue1,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                  ),
                ),
              ),
              Container(),
            ],
          );
  }
}
