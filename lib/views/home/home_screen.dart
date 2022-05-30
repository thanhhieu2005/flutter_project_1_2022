import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/category_model.dart';
import 'package:flutter_project_1/models/post.dart';
import 'package:flutter_project_1/view_models/post_provider.dart';
import 'package:flutter_project_1/views/home/sub_screens/post_detail_screen.dart';
import 'package:flutter_project_1/views/home/sub_screens/search_screen.dart';
import 'package:flutter_project_1/views/home/sub_screens/type_screen.dart';
import 'package:flutter_project_1/views/home/widgets/category_card.dart';
import 'package:flutter_project_1/views/home/widgets/popular_card.dart';
import 'package:flutter_project_1/views/home/widgets/notify_button.dart';
import 'package:flutter_project_1/views/home/widgets/new_discovery_card.dart';
import 'package:flutter_project_1/views/home/widgets/search_widget.dart';
import 'package:flutter_project_1/views/home/widgets/row_title_seeall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String nameRoute = '/home_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: nameRoute),
      builder: (_) => const HomeScreen(),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 90.h,
            automaticallyImplyLeading: false,
            elevation: 0,
            floating: true,
            backgroundColor: AppColors.kBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                'Discovery',
                                style: TextConfigs.kTextHeader1,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Vietnam',
                                style: TextConfigs.kTextHeader1,
                              ),
                            ),
                          ],
                        ),
                        NotifyButton(
                          onClick: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SearchWidget(
                  onTap: () {
                    Navigator.pushNamed(context, SearchScreen.nameRoute);
                  },
                  readOnly: true,
                ),
                SizedBox(
                  height: 16.h,
                ),
                // List category -> sau đổi thành list.builder
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Consumer<PostProvider>(
                      builder: (context, provider, child) {
                    return Row(
                      children: provider.categories
                          .map((e) => [
                                CategoryCard(
                                  icon: e.icon,
                                  title: e.title,
                                  onClick: () async {
                                    await Provider.of<PostProvider>(context,
                                            listen: false)
                                        .getPostByType(e.type);
                                    Navigator.pushNamed(
                                      context,
                                      TypeScreen.nameRoute,
                                      arguments:
                                          TypeScreenArgument(provider, e),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                              ])
                          .expand((element) => element)
                          .toList(),
                    );
                  }),
                ),
                SizedBox(
                  height: 24.h,
                ),
                RowTitleSeeAll(
                  onTapSeeAll: () {},
                  title: 'Popular Destination',
                ),
                SizedBox(
                  height: 16.h,
                ),
                Consumer<PostProvider>(builder: (context, provider, child) {
                  var item = provider.popularPost;
                  return SingleChildScrollView(
                    child: Row(
                      children: item
                          .map((e) => [
                                PopularCard(
                                  linkImage: e.images.first,
                                  titleCard: e.postName,
                                  district: e.postName,
                                  pointEvaluation: e.rating.toString(),
                                  onClick: () async {
                                    await Provider.of<PostProvider>(context,
                                            listen: false)
                                        .getUserById(e.sharer);
                                    Navigator.pushNamed(
                                      context,
                                      PostDetailScreen.nameRoute,
                                      arguments:
                                          PostDetailArgument(provider, e),
                                    );
                                  },
                                  province: e.province,
                                  road: e.road,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                              ])
                          .expand((element) => element)
                          .toList(),
                    ),
                    scrollDirection: Axis.horizontal,
                  );
                }),
                SizedBox(
                  height: 24.h,
                ),
                RowTitleSeeAll(
                  onTapSeeAll: () {},
                  title: 'New Discovey',
                ),
                SizedBox(
                  height: 16.h,
                ),
                // Làm List view builder
                NewDiscoveryCard(
                  linkImage:
                      'https://haycafe.vn/wp-content/uploads/2022/01/Hinh-anh-Ha-Long.jpg',
                  address: 'Ha Long Bay',
                  titleCard: 'Quang Ninh',
                  onClick: () {
                    Navigator.pushNamed(context, PostDetailScreen.nameRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostDetailArgument {
  final PostProvider provider;
  final Post post;

  PostDetailArgument(this.provider, this.post);
}

class TypeScreenArgument {
  final PostProvider provider;
  final Category category;

  TypeScreenArgument(this.provider, this.category);
}
