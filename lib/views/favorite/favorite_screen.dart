import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/others/argument_model.dart';
import 'package:flutter_project_1/view_models/favorite_post_provider.dart';
import 'package:flutter_project_1/views/account/widgets/post_moderation_card_widget.dart';
import 'package:flutter_project_1/views/home/sub_screens/post_detail_screen.dart';
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
  late FavoritetProvider favoritetProvider;

  @override
  void didChangeDependencies() {
    favoritetProvider = Provider.of<FavoritetProvider>(context, listen: false);
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      favoritetProvider.setUpFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FavoritetProvider>(
          builder: (context, favoriteProvider, child) {
        final listFavorite = favoritetProvider.listFavoritePosts;
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final eachPost = listFavorite[index];
              return listFavorite.isNotEmpty
                  ? PostModerationCard(
                      firstImage: eachPost.images.first,
                      namePostModeration: eachPost.postName,
                      location: eachPost.district + ", " + eachPost.province,
                      date: '06/06/2021',
                      onTap: () async {
                        await favoriteProvider.getUserById(eachPost.sharer);

                        Navigator.pushNamed(
                          context,
                          PostDetailScreen.nameRoute,
                          arguments: DestinationPostDetailArgument(
                            eachPost,
                            favoritetProvider.sharer!,
                          ),
                        );
                      },
                      isPending: false,
                    )
                  : Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                    );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 8.h,
                ),
            itemCount: listFavorite.length);
      }),
    );
  }
}
