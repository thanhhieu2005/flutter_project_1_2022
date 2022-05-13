import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/comment_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/evaluate_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/post_images_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/info_des_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/sharer_post_widget.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/color_config.dart';

class PostDetailCustom extends StatefulWidget {
  static const String nameRoute = '/post_detail_custom';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const PostDetailCustom(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const PostDetailCustom({Key? key}) : super(key: key);

  @override
  State<PostDetailCustom> createState() => _PostDetailCustomState();
}

class _PostDetailCustomState extends State<PostDetailCustom> {
  final List<String> urlImages = [
    'https://haycafe.vn/wp-content/uploads/2022/01/Hinh-anh-Ha-Long.jpg',
    'https://dambritourist.vn/tai-anh-vinh-ha-long/imager_5_15190_700.jpg',
    'https://dambritourist.vn/tai-anh-vinh-ha-long/imager_7_15190_700.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: double.maxFinite,
                height: 300.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://haycafe.vn/wp-content/uploads/2022/01/Hinh-anh-Ha-Long.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              // left: 8.w,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 72.h,
                  left: 8.w,
                  right: 8.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                      currentWidgetContext: context,
                      backgroundColor: AppColors.kColor1,
                      iconColor: AppColors.kColor0,
                      height: 32.w,
                      width: 32.w,
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              top: 250.h,
              child: Container(
                width: 1.sw,
                decoration: const BoxDecoration(
                  color: AppColors.kBackgroundColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const InfoDestinationWidget(
                          address: 'Quang Ninh, Viet Nam',
                          locationDiscovery: 'Ha Long Bay',
                          rating: 5,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Description',
                                style: TextConfigs.kText24_1.copyWith(
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'description aaaaaaaaaaaaa\n a\n a\n a\n ',
                                style: TextConfigs.kText16_1.copyWith(
                                  color: AppColors.kColor0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        PostImagesWidget(urlImages: urlImages),
                        SizedBox(
                          height: 8.h,
                        ),
                        SizedBox(
                          width: 1.sw,
                          child: CommentWidget(
                            countComment: '205',
                            onClick: () {},
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const EvaluateWidget(),
                        SizedBox(
                          height: 16.h,
                        ),
                        SharerPostWidget(
                          onClick: () {},
                        ),
                      ],
                    ),
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
