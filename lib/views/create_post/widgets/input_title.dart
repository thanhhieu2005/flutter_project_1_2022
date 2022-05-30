import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/color_config.dart';

class InputTitleWidget extends StatelessWidget {
  final bool isRequired;
  final String title;
  const InputTitleWidget({
    Key? key,
    required this.isRequired,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: RichText(
        text: TextSpan(
          text: title,
          style: TextConfigs.kTextSubtitle,
          children: <TextSpan>[
            isRequired
                ? TextSpan(
                    text: '*',
                    style: TextConfigs.kTextSubtitle.copyWith(
                      color: AppColors.kColor3,
                    ),
                  )
                : const TextSpan(),
          ],
        ),
      ),
    );
  }
}
