import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/views/home/widgets/search_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../configs/text_config.dart';
import '../../../widgets/custom_back_button.dart';

class SearchScreen extends StatelessWidget {
  static const String nameRoute = '/search_screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SearchScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const SearchScreen({Key? key}) : super(key: key);

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
            leadingWidth: 48.w,
            leading: CustomBackButton(
              backgroundColor: AppColors.kColor1,
              iconColor: AppColors.kColor0,
              currentWidgetContext: context,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            'Search',
                            style: TextConfigs.kTextHeader1,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Your Destination',
                            style: TextConfigs.kTextHeader1,
                          ),
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
              vertical: 10.h,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                const SearchWidget(readOnly: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
