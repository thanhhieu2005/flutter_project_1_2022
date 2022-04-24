import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchWidget extends StatefulWidget {
  final VoidCallback onTap;
  const SearchWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.kLightBlue4,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: "Search",
          hintStyle: TextConfigs.kText16_1.copyWith(
            color: AppColors.kDarkBlue1,
            fontStyle: FontStyle.italic,
          ),
          prefixIcon: InkWell(
            onTap: widget.onTap,
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: SvgPicture.asset(
                "assets/icons/ic_search.svg",
                height: 28.h,
                width: 28.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
