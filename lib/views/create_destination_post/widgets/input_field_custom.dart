import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';

class InputFieldCreatePost extends StatefulWidget {
  final int maxLines;
  final TextInputType keyboardType;
  final bool isRequired;
  final TextEditingController controller;
  const InputFieldCreatePost({
    Key? key,
    required this.maxLines,
    required this.keyboardType,
    required this.isRequired,
    required this.controller,
  }) : super(key: key);

  @override
  State<InputFieldCreatePost> createState() => _InputFieldCreatePostState();
}

class _InputFieldCreatePostState extends State<InputFieldCreatePost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadowConfig.kShadowGrey,
        ],
      ),
      child: Form(
        child: TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: widget.maxLines,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (widget.isRequired) {
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
          keyboardType: widget.keyboardType,
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
