import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/text_config.dart';
import 'package:flutter_project_1/models/others/argument_model.dart';
import 'package:flutter_project_1/view_models/discovery/discovery_provider.dart';
import 'package:flutter_project_1/views/discovery/dicovery_post_cart.dart';
import 'package:flutter_project_1/views/discovery/discovery_cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/color_config.dart';
import '../../widgets/button/custom_back_button.dart';
import '../../widgets/post_card.dart';
import '../../widgets/title_appbar_widget.dart';
import '../home/sub_screens/post_detail_screen.dart';
import '../home/widgets/popular_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscoveryDetailScreen extends StatefulWidget {
  static const String nameRoute = '/discovery_detail_screen';
  static Route route(setting) {
    return MaterialPageRoute(
      builder: (_) => DiscoveryDetailScreen(),
      settings: setting,
    );
  }

  @override
  State<DiscoveryDetailScreen> createState() => _DiscoveryDetailScreenState();
}

class _DiscoveryDetailScreenState extends State<DiscoveryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    DiscoveryDetailArgument argument =
        ModalRoute.of(context)!.settings.arguments as DiscoveryDetailArgument;
    var posts = argument.provider.typeList;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: CustomBackButton(
              width: 30.w,
              height: 30.h,
              onTapBack: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.transparent,
              iconColor: Colors.white,
              isCircleRounded: true)),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              image: DecorationImage(
                image: NetworkImage(argument.category.thumb),
                fit: BoxFit.fill,
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
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(argument.category.title.toUpperCase(),
                        style: GoogleFonts.creteRound()
                            .copyWith(fontSize: 20.sp, color: Colors.white)),
                    Text("Ready for an adventure ?",
                        style: GoogleFonts.creteRound().copyWith(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(argument.category.subtitle,
                        style: GoogleFonts.creteRound().copyWith(
                            fontSize: 24.sp,
                            color: Colors.white.withOpacity(0.7))),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 170.h,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return posts.isNotEmpty
                                ? DiscoveryPostCard(
                                    onClick: () async {
                                      await Provider.of<DiscoveryProvider>(
                                              context,
                                              listen: false)
                                          .getUserById(posts[index].sharer);
                                      Navigator.pushNamed(
                                        context,
                                        PostDetailScreen.nameRoute,
                                        arguments:
                                            DestinationPostDetailArgument(
                                          posts[index],
                                          argument.provider.sharer!,
                                        ),
                                      );
                                    },
                                    post: posts[index],
                                  )
                                : Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 64.h),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/ic_nodata.svg",
                                            height: 48.h,
                                            width: 48.h,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .noDestinationNoti,
                                            style: TextConfigs.kText24_1
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                                width: 30.w,
                              ),
                          itemCount: posts.isEmpty ? 0 : posts.length),
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
