import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TagTypeWidget extends StatelessWidget {
  const TagTypeWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final DestinationPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        : post.type == PostType.city
                            ? 'assets/icons/ic_city.svg'
                            : post.type == PostType.summer
                                ? 'assets/icons/ic_city.svg'
                                : post.type == PostType.wild
                                    ? 'assets/icons/ic_city.svg'
                                    : post.type == PostType.happyWeekend
                                        ? 'assets/icons/ic_city.svg'
                                        : 'assets/icons/ic_city.svg',
            width: 24.w,
            height: 24.h,
          ),
        ],
      ),
    );
  }
}
