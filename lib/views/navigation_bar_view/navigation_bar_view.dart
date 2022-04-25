import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/views/account/account_screen.dart';
import 'package:flutter_project_1/views/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBarView extends StatefulWidget {
  static const id = "HomeScreen";
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

  // screen
  final mainScreen = [
    const HomeScreen(),
    const Center(
      // ignore: prefer_const_constructors
      child: Text(
        'Discovery Screen',
        // ignore: unnecessary_const
        style: const TextStyle(
          fontSize: 50,
        ),
      ),
    ),
    const Center(
      // ignore: prefer_const_constructors
      child: Text(
        'Favorite Screen',
        // ignore: unnecessary_const
        style: const TextStyle(
          fontSize: 50,
        ),
      ),
    ),
    const AccountScreen(),
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
                labelTextStyle: MaterialStateProperty.all(
                  TextConfigs.kText12W500Green1.copyWith(
                    color: AppColors.kColor0,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
                      "assets/icons/ic_discovery.svg",
                      color: AppColors.kColor2,
                    ),
                    selectedIcon: SvgPicture.asset(
                      "assets/icons/ic_discovery.svg",
                      color: AppColors.kLightBlue3,
                    ),
                    label: 'Discovery',
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
        // BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: AppColors.kColor1,
        //   // iconSize: 32.h,
        //   showUnselectedLabels: false,
        //   showSelectedLabels: false,
        //   currentIndex: currentIndex,
        //   onTap: (index) => setState(() => currentIndex = index),
        //   // ignore: prefer_const_literals_to_create_immutables
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: SvgPicture.asset(
        //           "assets/icons/ic_homepage.svg",
        //           color: AppColors.kColor2,
        //         ),
        //         activeIcon: SvgPicture.asset(
        //           "assets/icons/ic_homepage.svg",
        //           color: AppColors.kLightBlue3,
        //         ),
        //         label: ''),
        //     BottomNavigationBarItem(
        //         icon: SvgPicture.asset(
        //           "assets/icons/ic_discovery.svg",
        //           color: AppColors.kColor2,
        //         ),
        //         activeIcon: SvgPicture.asset(
        //           "assets/icons/ic_discovery.svg",
        //           color: AppColors.kLightBlue3,
        //         ),
        //         label: ''),
        //     BottomNavigationBarItem(
        //         icon: SvgPicture.asset(
        //           "assets/icons/ic_favorite.svg",
        //           color: AppColors.kColor2,
        //         ),
        //         activeIcon: SvgPicture.asset(
        //           "assets/icons/ic_favorite.svg",
        //           color: AppColors.kLightBlue3,
        //         ),
        //         label: ''),
        //     BottomNavigationBarItem(
        //         icon: SvgPicture.asset(
        //           "assets/icons/ic_user.svg",
        //           color: AppColors.kColor2,
        //         ),
        //         activeIcon: SvgPicture.asset(
        //           "assets/icons/ic_user.svg",
        //           color: AppColors.kLightBlue3,
        //         ),
        //         label: ''),
        //   ],
        // ),
      ],
    );
  }
}
