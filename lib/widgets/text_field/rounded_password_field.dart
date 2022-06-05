import 'package:flutter/material.dart';
import 'package:flutter_project_1/view_models/login/sign_up_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../configs/color_config.dart';

class RoundedPasswordField extends StatefulWidget {
  final String pwdToConfirm;
  final bool isConfirmPwd;
  final TextEditingController controller;
  // final TextEditingController controller;
  const RoundedPasswordField({
    Key? key,
    this.pwdToConfirm = "",
    this.isConfirmPwd = false,
    required this.controller,
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
      child: Form(child: Consumer<SignUpProvider>(
        builder: (context, provider, child) {
          return TextFormField(
            controller: widget.controller,
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
                if (widget.isConfirmPwd) {
                  if (provider.pwdController.text != value) {
                    return "Confirm password does not match!";
                  } else {
                    return null;
                  }
                }
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
                    _passwordVisibility
                        ? Icons.visibility_off
                        : Icons.visibility,
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
          );
        },
      )),
    );
  }
}
