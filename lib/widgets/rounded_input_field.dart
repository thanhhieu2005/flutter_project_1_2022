import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/text_field_container.dart';
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
          prefixIcon: Icon(
            icon,
            color: AppColors.kPrimaryColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(29),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.kPrimaryColor),
            borderRadius: BorderRadius.circular(29),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(29),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(29),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}
