import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextInputType inputType;
  final TextEditingController controller;
  final bool readOnly;
  const TextFormFieldCustom({
    Key? key,
    required this.inputType,
    required this.controller,
    required this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kColor1,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          readOnly: readOnly,
          controller: controller,
          maxLines: 1,
          keyboardType: inputType,
          decoration: const InputDecoration(
            fillColor: AppColors.kColor1,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
