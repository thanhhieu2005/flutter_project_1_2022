import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/post_provider.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/comment_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/evaluate_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/post_images_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/info_des_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/sharer_post_widget.dart';
import 'package:flutter_project_1/widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../configs/color_config.dart';
import '../../../models/others/argument_model.dart';

class PostDetailScreen extends StatefulWidget {
  static const String nameRoute = '/post_detail_custom';
  static Route route(RouteSettings settings) {
    PostDetailArgument args = settings.arguments as PostDetailArgument;
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<PostProvider>.value(
        value: args.provider,
        child: const PostDetailScreen(),
      ),
      settings: settings,
    );
  }

  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    PostDetailArgument args =
        ModalRoute.of(context)!.settings.arguments as PostDetailArgument;
    final post = args.post;
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(post.images.first),
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
                        InfoDestinationWidget(
                          province: post.province,
                          postName: post.postName,
                          rating: post.rating,
                          district: post.district,
                          road: post.road,
                          type: post.type,
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
                                post.description.replaceAll("   ", '\n'),
                                style: TextConfigs.kText16_1.copyWith(
                                  color: AppColors.kColor0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        PostImagesWidget(urlImages: post.images),
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
                          sharer: args.provider.sharer!,
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
