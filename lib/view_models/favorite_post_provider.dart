import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/favorite_post.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';

class FavoriteProvider extends ChangeNotifier {
  late FavoriteDestinationPost _favoriteDestinationPost;

  VatractionUser? sharer;

  List<DestinationPost> _listFavoritePosts = [];

  FavoriteProvider() {
    setUpFavorite();
  }

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

  void onClickFavoriteButton(bool isLike, String destinationPostId) async {
    if (!isLike) {
      _favoriteDestinationPost.listIdDestinationPost.add(destinationPostId);

      var newFaveritePost =
          await DestinationPostRepo.getPostById(destinationPostId);
      listFavoritePosts.add(newFaveritePost);
    } else {
      _favoriteDestinationPost.listIdDestinationPost
          .removeWhere((element) => element == destinationPostId);
      _listFavoritePosts.removeWhere(
          (element) => element.destinationPostId == destinationPostId);
    }

    await DestinationPostRepo().updateFavoritePost(_favoriteDestinationPost);
    notifyListeners();
  }

  bool isLike(String destinationPostId) {
    bool isLike = false;
    for (var element in listFavoritePosts) {
      if (element.destinationPostId == destinationPostId) {
        isLike = true;
      }
    }
    return isLike;
  }

  int statisticalTypePost(PostType postType) {
    int count = 0;
    for (var element in listFavoritePosts) {
      if (element.type == postType) {
        count++;
      }
    }
    return count;
  }
}
