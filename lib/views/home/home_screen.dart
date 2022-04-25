import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/category_model.dart';
import 'package:flutter_project_1/views/home/widgets/category_card.dart';
import 'package:flutter_project_1/views/home/widgets/new_discovery_card.dart';
import 'package:flutter_project_1/views/home/widgets/notify_button.dart';
import 'package:flutter_project_1/views/home/widgets/popular_card.dart';
import 'package:flutter_project_1/views/home/widgets/search_widget.dart';
import 'package:flutter_project_1/views/home/widgets/row_title_seeall.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  static const String nameRoute = '/home_screeen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        // physics: NeverScrollableScrollPhysics(),
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
              children: [
                SearchWidget(
                  onTap: () {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                // List category -> sau đổi thành list.builder
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      home_categories.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: CategoryCard(
                          icon: home_categories[index].icon,
                          title: home_categories[index].title,
                          onClick: () {},
                        ),
                      ),
                    ),
                  ),
                ),
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
                  linkImage: 'https://picsum.photos/250?image=9',
                  titleCard: 'Nha Trang',
                  address: 'Khanh Hoa, Viet Nam',
                  pointEvaluation: '4.8',
                  onClick: () {},
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
                // Làm List view builder
                PopularCard(
                  linkImage: 'https://picsum.photos/250?image=9',
                  address: 'Ha Long Bay',
                  titleCard: 'Quang Ninh',
                  onClick: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
