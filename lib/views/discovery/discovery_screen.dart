import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/others/argument_model.dart';
import 'package:flutter_project_1/view_models/discovery/discovery_provider.dart';
import 'package:flutter_project_1/views/discovery/discovery_cart.dart';
import 'package:flutter_project_1/views/discovery/discovery_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/color_config.dart';
import '../../widgets/title_appbar_widget.dart';
import '../home/widgets/popular_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [];
        },
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                image: const DecorationImage(
                  image: AssetImage("assets/icons/adventure.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Container(
                color: AppColors.kPrimaryColor.withOpacity(0.2),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Take your",
                                style: GoogleFonts.creteRound().copyWith(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Row(
                              children: [
                                Text("backpack ",
                                    style: GoogleFonts.creteRound().copyWith(
                                        color: AppColors.kTextLightPrimary,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold)),
                                Text("and",
                                    style: GoogleFonts.creteRound().copyWith(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                            Text("discover the world",
                                style: GoogleFonts.creteRound().copyWith(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                                "Find and discover thousands of amazing place around you to your new world of interest",
                                style: GoogleFonts.creteRound().copyWith(
                                    fontSize: 16.sp, color: Colors.grey)),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Consumer<DiscoveryProvider>(
                            builder: (context, provider, child) {
                          return SizedBox(
                            height: 400.h,
                            child: Align(
                              alignment: Alignment.center,
                              child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final eachPost = provider.categories[index];
                                    return DiscoveryCard(
                                      subtitle: eachPost.subtitle,
                                      title: eachPost.title,
                                      onClick: () async {
                                        await provider.getDestinationPostByType(
                                            eachPost.type);
                                        Navigator.pushNamed(context,
                                            DiscoveryDetailScreen.nameRoute,
                                            arguments: DiscoveryDetailArgument(
                                                eachPost, provider));
                                      },
                                      icon: eachPost.icon,
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                  itemCount: provider.categories.length),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 65.h)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
