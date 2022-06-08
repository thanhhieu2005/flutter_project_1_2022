import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/post/destination_post_provider.dart';
import 'package:flutter_project_1/view_models/post/post_detail_provider.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/evaluate_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/post_images_widget.dart';
import 'package:flutter_project_1/widgets/info_des_post_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/widgets/sharer_post_widget.dart';
import 'package:flutter_project_1/widgets/button/custom_back_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../configs/color_config.dart';
import '../../../models/others/argument_model.dart';

class PostDetailScreen extends StatefulWidget {
  static const String nameRoute = '/post_detail_custom';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<PostDetailProvider>(
        create: (_) => PostDetailProvider(),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DestinationPostDetailArgument postDetailArgument = ModalRoute.of(context)!
        .settings
        .arguments as DestinationPostDetailArgument;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 64.h,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(
                  onTapBack: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: AppColors.kColor1.withOpacity(0.55),
                  iconColor: AppColors.kColor1,
                  height: 32.w,
                  width: 32.w,
                  isCircleRounded: true,
                ),
              ],
            ),
            backgroundColor: AppColors.kBackgroundColor,
            elevation: 0,
            pinned: true,
            floating: true,
            expandedHeight: 240.h,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        postDetailArgument.post.images.first,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.kBackgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InfoDestinationWidget(
                      post: postDetailArgument.post,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        // right: 8.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context).description,
                            style: TextConfigs.kText24_1.copyWith(
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            postDetailArgument.post.description
                                .replaceAll("   ", '\n'),
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
                    PostImagesWidget(urlImages: postDetailArgument.post.images),
                    // SizedBox(
                    //   height: 8.h,
                    // ),
                    // SizedBox(
                    //   width: 1.sw,
                    //   child: CommentWidget(
                    //     countComment: '205',
                    //     onClick: () {},
                    //   ),
                    // ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Consumer<PostDetailProvider>(
                        builder: (context, postDetailProvider, child) {
                      return EvaluateWidget(
                        wiget: RatingBar.builder(
                          minRating: 1,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: AppColors.kColor4,
                          ),
                          onRatingUpdate: (rating) => setState(() {
                            postDetailProvider.ratingValue = rating;
                            postDetailProvider.evaluationDestinationPost(
                                postDetailArgument.post);
                          }),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 16.h,
                    ),
                    SharerPostWidget(
                      onClick: () {},
                      sharer: postDetailArgument.sharer,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
