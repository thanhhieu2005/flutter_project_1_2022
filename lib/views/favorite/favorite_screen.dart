import 'package:flutter/material.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/models/others/argument_model.dart';
import 'package:flutter_project_1/view_models/favorite_post_provider.dart';
import 'package:flutter_project_1/widgets/general_post_card.dart';
import 'package:flutter_project_1/views/home/sub_screens/post_detail_screen.dart';
import 'package:flutter_project_1/widgets/title_appbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static const String nameRoute = '/favorite_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: nameRoute),
      builder: (_) => const FavoriteScreen(),
    );
  }

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteProvider initFavoriteProvider;

  @override
  void didChangeDependencies() {
    initFavoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initFavoriteProvider.setUpFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                background: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                       TitleAppBarWidget(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        aboveText: "Your",
                        underText: "Destination",
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Image.asset(
                      //     "assets/images/statistical.png",
                      //     height: 32.h,
                      //     width: 32.h,
                      //     scale: 1.0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
              final listFavorite = favoriteProvider.listFavoritePosts;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final eachPost = listFavorite[index];
                      return listFavorite.isNotEmpty
                          ? GeneralPostCard(
                              firstImage: eachPost.images.first,
                              namePostModeration: eachPost.postName,
                              location:
                                  "${eachPost.district}, ${eachPost.province}",
                              date: '06/06/2021',
                              onTap: () async {
                                await favoriteProvider
                                    .getUserById(eachPost.sharer);

                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(
                                  context,
                                  PostDetailScreen.nameRoute,
                                  arguments: DestinationPostDetailArgument(
                                    eachPost,
                                    favoriteProvider.sharer!,
                                  ),
                                );
                              },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
