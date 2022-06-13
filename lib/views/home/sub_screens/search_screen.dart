import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/view_models/post/search_post_provider.dart';
import 'package:flutter_project_1/views/home/widgets/search_widget.dart';
import 'package:flutter_project_1/widgets/title_appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../configs/text_config.dart';
import '../../../widgets/button/custom_back_button.dart';
import '../../../widgets/general_post_card.dart';

class SearchScreen extends StatefulWidget {
  static const String nameRoute = '/search_screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SearchScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchPostProvider searchPostProvider;

  @override
  void initState() {
    searchPostProvider =
        Provider.of<SearchPostProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      searchPostProvider.onDataChange();
    });
  }

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
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomBackButton(
                          height: 40.w,
                          width: 40.w,
                          backgroundColor: AppColors.kColor1,
                          iconColor: AppColors.kColor0,
                          onTapBack: () {
                            Navigator.pop(context);
                            searchPostProvider.clearListPost();
                          },
                          isCircleRounded: false,
                        ),
                      ),
                      const TitleAppBarWidget(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        aboveText: "Search",
                        underText: "Your Destination",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Consumer<SearchPostProvider>(
          builder: (context, provider, child) {
            final listFavorite = provider.listPostModeration;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Column(
                children: [
                  const SearchWidget(
                    readOnly: false,
                    fillColors: AppColors.kLightBlue4,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final eachPost = listFavorite[index];
                        return listFavorite.isNotEmpty
                            ? GeneralPostCard(
                                firstImage: eachPost.images.first,
                                namePostModeration: eachPost.postName,
                                location: eachPost.district +
                                    ", " +
                                    eachPost.province,
                                date: '06/06/2021',
                                onTap: () async {},
                                isPending: false,
                                rating: eachPost.rating,
                              )
                            : Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.red,
                                ),
                              );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                            height: 8.h,
                          ),
                      itemCount: listFavorite.length),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
