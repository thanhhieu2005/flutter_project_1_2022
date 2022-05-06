import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstInfoPost extends StatefulWidget {
  final List<String> urlImages;
  const FirstInfoPost({
    Key? key,
    required this.urlImages,
  }) : super(key: key);

  @override
  State<FirstInfoPost> createState() => _FirstInfoPostState();
}

class _FirstInfoPostState extends State<FirstInfoPost> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.urlImages
              .map(
                (item) => Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: Image.network(
                          item,
                          fit: BoxFit.fill,
                          width: 1.sw,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 20.h,
                    //   left: 20.w,
                    //   child: Container(
                    //     padding: EdgeInsets.all(15.w),
                    //     decoration: const BoxDecoration(
                    //       color: Color.fromARGB(96, 31, 56, 44),
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(10),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       widget.postName,
                    //       style: TextConfigs.kTextSubtitleBold.copyWith(
                    //         color: AppColors.kColor1,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
              .toList(),
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: widget.urlImages.map((e) {
            int index = widget.urlImages.indexOf(e);
            return Container(
              height: 6.h,
              width: 6.h,
              margin: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 4.w,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? const Color.fromRGBO(0, 180, 216, 0.7)
                    : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
