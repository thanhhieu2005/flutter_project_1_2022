import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final TextEditingController? textController;
  final Function(String) onChange;
  final bool readOnly;
  final Color fillColors;
  const SearchWidget({
    Key? key,
    this.onTap,
    this.textController,
    required this.onChange,
    required this.readOnly,
    required this.fillColors,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: widget.textController,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        showCursor: !widget.readOnly,
        onChanged: widget.onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColors,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: AppLocalizations.of(context).search,
          hintStyle: TextConfigs.kText16White.copyWith(
            color: AppColors.kDarkBlue1,
          ),
          prefixIcon: InkWell(
            // onTap: widget.onTap,
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
