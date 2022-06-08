import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/favorite_post.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';

class FavoritetProvider extends ChangeNotifier {
  late FavoriteDestinationPost _favoriteDestinationPost;

  VatractionUser? sharer;

  List<DestinationPost> _listFavoritePosts = [];

  List<DestinationPost> get listFavoritePosts {
    return _listFavoritePosts;
  }

  FavoriteDestinationPost get favoriteDestinationPost {
    return _favoriteDestinationPost;
  }

  void setUpFavorite() async {
    _favoriteDestinationPost = await DestinationPostRepo()
        .setUpFavoriteFoodByUserId(localCurrentUser.uid);

    _listFavoritePosts = await DestinationPostRepo()
        .getListDestinationPostFavorite(_favoriteDestinationPost);
    notifyListeners();
  }

  Future<void> getUserById(String uid) async {
    sharer = await DestinationPostRepo.getUserById(uid);
  }

  // void updateFavorite() async {
  //   notifyListeners();
  //   await DestinationPostRepo().updateFavoritePost(favoriteDestinationPost);
  // }

  // bool onClickFavoriteButton(bool isLike, String destinationPostId) {
  //   if (!isLike) {
  //     favoriteDestinationPost.listIdDestinantionPost.add(destinationPostId);
  //   } else {
  //     favoriteDestinationPost.listIdDestinantionPost
  //         .removeWhere((element) => element == destinationPostId);
  //   }

  //   updateFavorite;

  //   return !isLike;
  // }
}
