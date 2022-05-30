import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerDropdown extends StatelessWidget {
  final Widget dropDownWidget;
  const ContainerDropdown({
    Key? key,
    required this.dropDownWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      constraints: BoxConstraints(minHeight: 72.h),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.kColor1,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadowConfig.kShadowGrey,
        ],
      ),
      child: dropDownWidget,
    );
  }
}
