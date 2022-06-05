import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextInputType inputType;
  final TextEditingController controller;
  final bool readOnly, requiredText;
  const TextFormFieldCustom({
    Key? key,
    required this.inputType,
    required this.controller,
    required this.readOnly,
    required this.requiredText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        // color: AppColors.kColor1,
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
          validator: requiredText
              ? (value) {
                  if (value!.isEmpty) {
                    return "This field cannot be blank!";
                  } else {
                    return null;
                  }
                }
              : null,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: AppColors.kColor1,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.kPrimaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10)),
          ),
          style: !readOnly
              ? TextConfigs.kText16Black
              : TextConfigs.kText16Black.copyWith(
                  color: AppColors.kColor2,
                ),
        ),
      ),
    );
  }
}
