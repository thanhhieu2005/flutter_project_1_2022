import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/text_field_container.dart';
import '../configs/color_config.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  // final TextEditingController controller;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.hintText = "Your Password",
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
          prefixIcon: Icon(
            Icons.lock,
            color: AppColors.kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisibility ? Icons.visibility_off : Icons.visibility,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                _passwordVisibility = !_passwordVisibility;
              });
            },
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
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}
