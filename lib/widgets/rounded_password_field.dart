import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/text_field_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../configs/color_config.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  // final TextEditingController controller;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.hintText = "Password",
    // required this.controller,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  late bool _passwordVisibility;

  @override
  void initState() {
    _passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Form(
        autovalidateMode: AutovalidateMode.disabled,
        child: TextFormField(
          onChanged: widget.onChanged,
          obscureText: !_passwordVisibility,
          textInputAction: TextInputAction.done,
          // controller: widget.controller,
          validator: (val) =>
              val!.isNotEmpty ? null : "Password cannot be blank!",
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisibility ? Icons.visibility_off : Icons.visibility,
                size: 20.h,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisibility = !_passwordVisibility;
                });
              },
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          ),
        ),
      ),
    );
  }
}
