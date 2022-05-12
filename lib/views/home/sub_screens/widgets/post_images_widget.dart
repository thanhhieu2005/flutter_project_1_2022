import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostImagesWidget extends StatefulWidget {
  final List<String> urlImages;
  const PostImagesWidget({
    Key? key,
    required this.urlImages,
  }) : super(key: key);

  @override
  State<PostImagesWidget> createState() => _PostImagesWidgetState();
}

class _PostImagesWidgetState extends State<PostImagesWidget> {
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
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 1.sw,
                          height: 160.h,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
          options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              autoPlayInterval: const Duration(seconds: 4),
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
                // vertical: 8.h,
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
