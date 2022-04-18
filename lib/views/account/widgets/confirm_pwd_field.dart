import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/color_config.dart';

class ConfirmPasswordField extends StatefulWidget {
  final String newPassword;
  final ValueChanged<String> onChanged;
  const ConfirmPasswordField({
    Key? key,
    required this.onChanged,
    required this.newPassword,
  }) : super(key: key);

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  late bool _passwordVisibility;

  @override
  // ignore: must_call_super
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
          textInputAction: TextInputAction.done,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('[\\.|\\,| -]'))
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return "Confirm Password cannot be blank!";
            } else if (value != widget.newPassword) {
              return "Confirm Password doesn't match!";
            } else {
              return null;
            }
          },
          // value!.isNotEmpty ? null : "Password cannot be blank!",
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kColor1,
            border: InputBorder.none,
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
