import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/edgeInset_config.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvaluateWidget extends StatefulWidget {
  const EvaluateWidget({Key? key}) : super(key: key);

  @override
  State<EvaluateWidget> createState() => _EvaluateWidgetState();
}

class _EvaluateWidgetState extends State<EvaluateWidget> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsConfig.kOnlyLTR_20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Touch to Evaluate',
                      style: TextConfigs.kTextSubtitle.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    RatingBar.builder(
                      minRating: 1,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: AppColors.kColor4,
                      ),
                      onRatingUpdate: (rating) => setState(() {
                        this.rating = rating; // Hàm xử lý đánh giá
                        // ignore: avoid_print
                        print('$rating');
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
