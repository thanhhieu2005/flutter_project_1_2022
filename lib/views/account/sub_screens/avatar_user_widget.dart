import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';

class AvatarUserWidget extends StatelessWidget {
  final double width, height;
  final String linkImage;
  const AvatarUserWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.linkImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: AppColors.kColor1,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
        // ignore: prefer_const_constructors
        image: DecorationImage(
          image: NetworkImage(linkImage),
          fit: BoxFit.fill,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(65),
        ),
        border: Border.all(
          color: AppColors.kColor1,
          width: 3.0,
        ),
      ),
    );
  }
}
