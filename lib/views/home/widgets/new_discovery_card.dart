import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewDiscoveryCard extends StatelessWidget {
  final String linkImage, titleCard, address;
  final VoidCallback onClick;
  const NewDiscoveryCard({
    Key? key,
    required this.linkImage,
    required this.titleCard,
    required this.address,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 160.h,
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(linkImage),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 56.h,
                width: 160.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                  color: AppColors.kColor1,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          titleCard,
                          style: TextConfigs.kTextSubtitle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Expanded(
                        child: Text(
                          address,
                          style: TextConfigs.kText16Black.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
