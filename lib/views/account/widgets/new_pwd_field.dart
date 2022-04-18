// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const NewPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NewPasswordField> createState() => _NewPasswordFieldState();
}

class _NewPasswordFieldState extends State<NewPasswordField> {
  late bool _passwordVisibility;

  @override
  void initState() {
    _passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: TextFormField(
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: 1,
          obscureText: !_passwordVisibility,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return "Password cannot be blank!";
            } else if (value.length < 6) {
              return "Password must be more than 6 characters!";
            } else {
              return null;
            }
          },
          // value!.isNotEmpty ? null : "Password cannot be blank!",
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: AppColors.kColor1,
            suffixIcon: IconButton(
              icon: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Icon(
                  _passwordVisibility ? Icons.visibility_off : Icons.visibility,
                  size: 16.h,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                setState(() {
                  _passwordVisibility = !_passwordVisibility;
                });
              },
            ),
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
        ),
      ),
    );
  }
}
