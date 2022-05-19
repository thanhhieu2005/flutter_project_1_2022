import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/color_config.dart';

class DiscoveryScreen extends StatelessWidget {
  static const String nameRoute = '/discovery_screen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const DiscoveryScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: double.maxFinite,
                  height: 200.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://connect-assets.prosple.com/cdn/ff/bJ_LMraGaGaG0YgTv7V2at-dIdAseGPcEnTGYswdUuA/1628963520/public/styles/scale_and_crop_center_890x320/public/2021-08/myTravel-Banners_1.jpg?itok=9E9J_l3y'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
