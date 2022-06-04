import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImageWidget extends StatelessWidget {
  final void Function() onTap;
  const AddImageWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120.h,
        width: 120.h,
        decoration: BoxDecoration(
          color: AppColors.kColor1,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadowConfig.kShadowGrey],
        ),
        child: Icon(
          CupertinoIcons.plus,
          color: AppColors.kColor0,
          size: 32.h,
        ),
      ),
    );
  }
}

class NoticeImageText extends StatelessWidget {
  const NoticeImageText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Notice: ',
        style: TextConfigs.kText14Black.copyWith(
          color: AppColors.kPrimaryColor,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text:
                'The first image will be the background image of the post. You should choose 3 or more images',
            style: TextConfigs.kText14Black.copyWith(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
