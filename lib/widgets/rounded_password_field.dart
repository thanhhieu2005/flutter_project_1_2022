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
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      child: TextFormField(
        onChanged: widget.onChanged,
        obscureText: !_passwordVisibility,
        textInputAction: TextInputAction.done,
        // controller: widget.controller,
        validator: (val) =>
            val!.isNotEmpty ? null : "Password cannot be blank!",
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Icon(
                _passwordVisibility ? Icons.visibility_off : Icons.visibility,
                size: 20.h,
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
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kPrimaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
