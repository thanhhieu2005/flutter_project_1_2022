import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/text_field_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../configs/color_config.dart';

class RoundedInputField extends StatelessWidget {
  final String inputName;
  final IconData icon;
  final ValueChanged<String> onChanged;
  // final TextEditingController controller;
  const RoundedInputField({
    Key? key,
    required this.inputName,
    required this.icon,
    required this.onChanged,
    // required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.kColor1,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        TextFormField(
          // controller: controller,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          validator: (val) =>
              val!.isNotEmpty ? null : inputName + " can not be blank!",
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          ),
        ),
      ],
    );
  }
}
