import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/post.dart';
import 'package:flutter_project_1/view_models/post_provider.dart';
import 'package:flutter_project_1/views/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../configs/color_config.dart';
import '../../../widgets/custom_back_button.dart';

class TypeScreen extends StatelessWidget {
  static const String nameRoute = '/type_screen';
  static Route route(RouteSettings settings) {
    TypeScreenArgument args = settings.arguments as TypeScreenArgument;
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => ChangeNotifierProvider<PostProvider>.value(
        value: args.provider,
        child: const TypeScreen(),
      ),
    );
  }

  const TypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TypeScreenArgument args =
        ModalRoute.of(context)!.settings.arguments as TypeScreenArgument;
    final category = args.category;
    final posts = args.provider.typePost;
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            backgroundColor: AppColors.kPrimaryColor,
            pinned: true,
            elevation: 0,
            leadingWidth: 48.w,
            leading: CustomBackButton(
              currentWidgetContext: context,
              backgroundColor: AppColors.kColor1,
              iconColor: AppColors.kColor0,
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                right: 20.w,
                bottom: 12.h,
              ),
              expandedTitleScale: 1.4,
              title: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  category.intro,
                  style: TextConfigs.kText24_1.copyWith(
                    color: AppColors.kColor1,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  color: AppColors.kColor0,
                  image: DecorationImage(
                    image: NetworkImage(category.thumb),
                    fit: BoxFit.cover,
                    opacity: 1.75,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return posts.isNotEmpty
                    ? PostCard(
                        onClick: () {},
                        post: posts[index],
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 64.h),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/ic_nodata.svg",
                                height: 48.h,
                                width: 48.h,
                              ),
                              Text(
                                'Chưa có dữ liệu',
                                style: TextConfigs.kText24_1
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
              },
              childCount: posts.isNotEmpty ? posts.length : 1,
            ),
          ),
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.post,
    required this.onClick,
  }) : super(key: key);

  final Post post;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
        height: 90.h,
        width: 1.sw,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadowConfig.kShadowGrey,
            ]),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    // height: 60.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(post.images.first),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          post.postName,
                          style: TextConfigs.kTextSubtitle.copyWith(
                            color: AppColors.kColor0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Flexible(
                        child: Text(
                          post.road == ''
                              ? post.district + ', ' + post.province
                              : post.road! +
                                  ', ' +
                                  post.district +
                                  ', ' +
                                  post.province,
                          style: TextConfigs.kText16Black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 16.w,
              // top: 10.h,
              child: Container(
                height: 40.h,
                width: 64.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: AppColors.kColor4,
                  // boxShadow: [
                  //   BoxShadowConfig.kShadowGrey,
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '4',
                      style: TextConfigs.kTextSubtitle.copyWith(
                        color: AppColors.kColor1,
                      ),
                    ),
                    SvgPicture.asset("assets/icons/ic_star.svg"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
