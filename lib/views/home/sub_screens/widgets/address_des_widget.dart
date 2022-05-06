import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/EdgeInset_config.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressDestinationWidget extends StatelessWidget {
  final String locationDiscovery, address;
  const AddressDestinationWidget({
    Key? key,
    required this.locationDiscovery,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsConfig.kOnlyLTR_20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locationDiscovery,
            style: TextConfigs.kText24_1.copyWith(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/icons/ic_location.svg",
                color: AppColors.kTextColor1,
              ),
              Text(
                address,
                style: TextConfigs.kText16Black.copyWith(
                  color: AppColors.kTextColor1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
