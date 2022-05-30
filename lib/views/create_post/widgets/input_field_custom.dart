import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';

class InputFieldCreatePost extends StatelessWidget {
  final int maxLines;
  final TextInputType keyboardType;
  final bool isRequired;
  const InputFieldCreatePost({
    Key? key,
    required this.maxLines,
    required this.keyboardType,
    required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
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
      child: Form(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: maxLines,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (isRequired) {
              if (value!.isEmpty) {
                return "This field cannot be blank!";
              } else {
                return null;
              }
            } else {
              return null;
            }
          },
          style: TextConfigs.kText16Black,
          keyboardType: keyboardType,
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
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
