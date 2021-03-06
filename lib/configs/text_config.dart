import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_config.dart';

class TextConfigs {
  static final kFontFamily = GoogleFonts.roboto().fontFamily;
  static final kText16White = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    color: AppColors.kColor1,
  );

  static final kText22White = TextStyle(
    fontSize: 22.sp,
    fontFamily: kFontFamily,
    color: AppColors.kColor1,
  );

  static final kText22WhiteBold = TextStyle(
      fontSize: 22.sp,
      fontFamily: kFontFamily,
      color: AppColors.kColor1,
      fontWeight: FontWeight.bold);

  static final kText31SemiBoldLightPrimary = TextStyle(
      fontSize: 31.sp,
      fontFamily: kFontFamily,
      color: AppColors.kTextLightPrimary,
      fontWeight: FontWeight.bold);

  static final kText31SemiBoldWhite = TextStyle(
      fontSize: 31.sp,
      fontFamily: kFontFamily,
      color: AppColors.kColor1,
      fontWeight: FontWeight.bold);

  static final kText16Black = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    color: AppColors.kBlackColor,
  );

  static final kText14Black = TextStyle(
    fontSize: 14.sp,
    fontFamily: kFontFamily,
    color: AppColors.kBlackColor,
  );

  static final kText16Bold_1 = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.kColor1,
  );

  static final kText16kPrimary = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.normal,
    color: AppColors.kPrimaryColor,
  );

  static final kText16BoldKprimary = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.kPrimaryColor,
  );

  static final kText14White = TextStyle(
    fontSize: 14.sp,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w300,
    color: AppColors.kColor1,
  );

  static final kText16Primary = TextStyle(
    fontSize: 16.sp,
    fontFamily: kFontFamily,
    color: AppColors.kPrimaryColor,
  );

  static final kText24_1 = TextStyle(
    fontSize: 24.sp,
    fontFamily: kFontFamily,
    color: AppColors.kBlackColor,
  );

  static final kText24_2 = TextStyle(
    fontSize: 24.sp,
    fontFamily: kFontFamily,
    color: AppColors.kBlackColor,
    fontWeight: FontWeight.bold,
  );

  static final kText12W500Green1 = TextStyle(
    fontSize: 12.sp,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.kColor6,
  );

  static final kTextSubtitle = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.kBlackColor,
  );

  static final kTextSubtitleBold = TextStyle(
    fontSize: 20.sp,
    fontFamily: kFontFamily,
    color: AppColors.kBlackColor,
    fontWeight: FontWeight.bold,
  );

  static final kTextBody1KPrimaryBold = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 20.sp,
    color: AppColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
  );

  static final kTextHeader1 = TextStyle(
    fontSize: 39.sp,
    fontFamily: kFontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.kBlackColor,
  );

  static final kTextHeader2 = TextStyle(
    fontFamily: kFontFamily,
    fontSize: 31.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.kBlackColor,
  );

  String addressSetUp(
      String road, String wards, String district, String province) {
    if (road.isEmpty) {
      return (wards + ', ' + district + ", " + province);
    }
    return (road + ", " + wards + ', ' + district + ", " + province);
  }
}
