import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageItemWidget extends StatelessWidget {
  final File image;
  final void Function() onTap;
  const ImageItemWidget({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 120.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: const [BoxShadowConfig.kShadowGrey],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              image,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.all(4.h),
                height: 19.h,
                width: 19.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.multiply,
                  color: AppColors.kColor0,
                  size: 14.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
