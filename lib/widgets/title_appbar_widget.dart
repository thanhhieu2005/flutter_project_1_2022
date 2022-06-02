import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configs/text_config.dart';

class TitleAppBarWidget extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String aboveText, underText;
  const TitleAppBarWidget({
    Key? key,
    required this.crossAxisAlignment,
    required this.aboveText,
    required this.underText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              aboveText,
              style: TextConfigs.kTextHeader1,
            ),
          ),
          Expanded(
            child: Text(
              underText,
              style: TextConfigs.kTextHeader1,
            ),
          ),
        ],
      ),
    );
  }
}
