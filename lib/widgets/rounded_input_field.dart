import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/text_field_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../configs/color_config.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String inputName;
  final IconData icon;
  final ValueChanged<String> onChanged;
  // final TextEditingController controller;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.inputName,
    required this.icon,
    required this.onChanged,
    // required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        // controller: controller,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        validator: (val) =>
            val!.isNotEmpty ? null : inputName + "cannot be blank!",
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kPrimaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
