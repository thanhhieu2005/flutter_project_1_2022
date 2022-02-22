import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_config.dart';

class TextConfigs {
  static const kFontFamily = "DESIGN_FONT";
  static final kText16_1 = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    color: AppColors.kColor1,
  );

  static final kText16Bold_1 = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.kColor1,
  );
}
