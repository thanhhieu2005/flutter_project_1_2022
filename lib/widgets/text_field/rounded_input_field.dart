import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/app_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import '../../configs/color_config.dart';

class RoundedInputField extends StatelessWidget {
  final String inputName;
  final IconData icon;
  final TextEditingController controller;
  final Color fillColor;
  final bool hasHint;
  // final TextEditingController controller;
  const RoundedInputField(
      {Key? key,
      this.hasHint = false,
      required this.inputName,
      required this.icon,
      required this.controller,
      this.fillColor = AppColors.kColor1
      // required this.controller,
      })
      : super(key: key);
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
          style: TextConfigs.kText16Primary,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return "$inputName cannot be blank!";
            } else if (value.length < 6) {
              return "$inputName must be more than 6 characters!";
            } else {
              return null;
            }
          },
          // value!.isNotEmpty ? null : "Password cannot be blank!",
          keyboardType: TextInputType.text,
          decoration: hasHint
              ? InputDecoration(
                  hintStyle: TextConfigs.kText16Primary.copyWith(
                      color: AppColors.kPrimaryColor.withOpacity(0.5)),
                  hintText: inputName,
                  border: InputBorder.none,
                  filled: true,
                  fillColor: fillColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                )
              : InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: fillColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.kPrimaryColor),
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
