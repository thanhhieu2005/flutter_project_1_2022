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
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.kColor1,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: dropDownWidget,
    );
  }
}
