import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/view_models/account/setting_account_provider.dart';
import 'package:flutter_project_1/view_models/favorite_post_provider.dart';
import 'package:flutter_project_1/view_models/post/create_des_post_provider.dart';
import 'package:flutter_project_1/view_models/post/destination_post_provider.dart';
import 'package:flutter_project_1/views/account/setting_account_screen.dart';
import 'package:flutter_project_1/views/create_destination_post/create_destination_post_screen.dart';
import 'package:flutter_project_1/views/discovery/discovery_screen.dart';
import 'package:flutter_project_1/views/favorite/favorite_screen.dart';
import 'package:flutter_project_1/views/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NavigationBarView extends StatefulWidget {
  static const id = "/navigation_bar_view";
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const NavigationBarView(),
      settings: const RouteSettings(name: id),
    );
  }

  const NavigationBarView({Key? key}) : super(key: key);

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  int currentIndex = 0;

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return ChangeNotifierProvider<CreateDestinationPostProvider>(
          create: (context) => CreateDestinationPostProvider(),
          child: const CreateDestinationPostScreen(),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // screen
  final mainScreen = [
    ChangeNotifierProvider<DestinationPostProvider>(
      create: (_) => DestinationPostProvider(),
      child: const HomeScreen(),
    ),
    const DiscoveryScreen(),
    const Center(),
    const FavoriteScreen(),
    ChangeNotifierProvider<SettingAccountProvider>(
      create: (_) => SettingAccountProvider(),
      child: const SettingAccountScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IndexedStack(
          children: mainScreen,
          index: currentIndex,
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: 1.sw,
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: AppColors.kColor1,
                labelTextStyle: MaterialStateProperty.all(
                  TextConfigs.kText12W500Green1.copyWith(
                    color: AppColors.kColor0,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              ),
              child: NavigationBar(
                height: 60.h,
                backgroundColor: AppColors.kColor1,
                selectedIndex: currentIndex,
                onDestinationSelected: (index) =>
                    setState(() => currentIndex = index),
                destinations: [
                  NavigationDestination(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_homepage.svg",
                      color: AppColors.kColor2,
                    ),
                    selectedIcon: SvgPicture.asset(
                      "assets/icons/ic_homepage.svg",
                      color: AppColors.kLightBlue3,
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_discovery.svg",
                      color: AppColors.kColor2,
                    ),
                    selectedIcon: SvgPicture.asset(
                      "assets/icons/ic_discovery.svg",
                      color: AppColors.kLightBlue3,
                    ),
                    label: 'Discovery',
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        _createRoute(),
                      ),
                    },
                    child: Container(
                      height: 36.h,
                      width: 30.w,
                      padding: EdgeInsets.all(4.h),
                      margin: EdgeInsets.only(left: 8.w, right: 8.w),
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.circle,
                        color: AppColors.kLightBlue3,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/ic_add.svg",
                        color: AppColors.kColor1,
                      ),
                    ),
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_favorite.svg",
                      color: AppColors.kColor2,
                    ),
                    selectedIcon: SvgPicture.asset(
                      "assets/icons/ic_favorite.svg",
                      color: AppColors.kLightBlue3,
                    ),
                    label: 'Favorite',
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_user.svg",
                      color: AppColors.kColor2,
                    ),
                    selectedIcon: SvgPicture.asset(
                      "assets/icons/ic_user.svg",
                      color: AppColors.kLightBlue3,
                    ),
                    label: 'User',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
