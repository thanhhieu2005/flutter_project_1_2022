import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/views/home/sub_screens/post_detail_screen.dart';
import 'package:flutter_project_1/views/home/sub_screens/search_screen.dart';
import 'package:flutter_project_1/views/home/sub_screens/type_screen.dart';
import 'package:flutter_project_1/views/home/widgets/category_card.dart';
import 'package:flutter_project_1/views/home/widgets/popular_card.dart';
import 'package:flutter_project_1/views/home/widgets/notify_button.dart';
import 'package:flutter_project_1/views/home/widgets/new_discovery_card.dart';
import 'package:flutter_project_1/views/home/widgets/search_widget.dart';
import 'package:flutter_project_1/views/home/widgets/row_title_seeall.dart';
import 'package:flutter_project_1/widgets/title_appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/others/argument_model.dart';
import '../../view_models/post/destination_post_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String nameRoute = '/home_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: nameRoute),
      builder: (_) => const HomeScreen(),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DestinationPostProvider postProvider;
  @override
  void initState() {
    postProvider = Provider.of<DestinationPostProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      postProvider.onDataChange();
    });
  }

  @override
  void dispose() {
    postProvider.isDispose = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: NestedScrollView(
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleAppBarWidget(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          aboveText: AppLocalizations.of(context).titleHome,
                          underText: AppLocalizations.of(context).vietnam,
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
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  SearchWidget(
                    onChange: (value) {},
                    onTap: () {
                      Navigator.pushNamed(context, SearchScreen.nameRoute,
                          arguments: SearchScreenArgument(false));
                    },
                    readOnly: true,
                    fillColors: AppColors.kLightBlue4,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  // List category -> sau đổi thành list.builder
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Consumer<DestinationPostProvider>(
                        builder: (context, provider, child) {
                      return Row(
                        children: provider.categories
                            .map((e) => [
                                  CategoryCard(
                                    icon: e.icon,
                                    title: SettingPostType.setTitleType(
                                        e.type, context),
                                    onClick: () async {
                                      await Provider.of<
                                                  DestinationPostProvider>(
                                              context,
                                              listen: false)
                                          .getDestinationPostByType(e.type);
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
                    title: AppLocalizations.of(context).popularDesti,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Consumer<DestinationPostProvider>(
                      builder: (context, provider, child) {
                    var item = provider.popularDestinationPost.take(5);
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
                                      await Provider.of<
                                                  DestinationPostProvider>(
                                              context,
                                              listen: false)
                                          .getUserById(e.sharer);
                                      Navigator.pushNamed(
                                        context,
                                        PostDetailScreen.nameRoute,
                                        arguments:
                                            DestinationPostDetailArgument(
                                          e,
                                          provider.sharer!,
                                        ),
                                      );
                                    },
                                    province: e.province,
                                    road: e.road,
                                  ),
                                  SizedBox(
                                    width: 16.w,
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
                    title: AppLocalizations.of(context).newDesti,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  // Làm List view builder
                  Consumer<DestinationPostProvider>(
                      builder: (context, provider, child) {
                    var item = provider.listNewPost.take(5);
                    return SingleChildScrollView(
                      child: Row(
                        children: item
                            .map((e) => [
                                  NewDiscoveryCard(
                                    post: e,
                                    onClick: () async {
                                      await Provider.of<
                                                  DestinationPostProvider>(
                                              context,
                                              listen: false)
                                          .getUserById(e.sharer);
                                      Navigator.pushNamed(
                                        context,
                                        PostDetailScreen.nameRoute,
                                        arguments:
                                            DestinationPostDetailArgument(
                                          e,
                                          provider.sharer!,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                ])
                            .expand((element) => element)
                            .toList(),
                      ),
                      scrollDirection: Axis.horizontal,
                    );
                  }),
                  // container trang
                  Container(
                    height: 60.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
