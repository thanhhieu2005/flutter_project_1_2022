import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/argument_model.dart';
import 'package:flutter_project_1/view_models/post_provider.dart';
import 'package:flutter_project_1/views/home/sub_screens/post_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../configs/color_config.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/post_card.dart';

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
    final provider = args.provider;
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
                        onClick: () async {
                          await Provider.of<PostProvider>(context,
                                  listen: false)
                              .getUserById(posts[index].sharer);
                          Navigator.pushNamed(
                            context,
                            PostDetailScreen.nameRoute,
                            arguments:
                                PostDetailArgument(provider, posts[index]),
                          );
                        },
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
                                'Chưa có điểm du lịch',
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
