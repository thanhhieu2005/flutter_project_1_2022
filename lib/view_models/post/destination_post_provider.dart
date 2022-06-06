import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/configs/image_config.dart';
import 'package:flutter_project_1/models/others/category_model.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';

class DestinationPostProvider extends ChangeNotifier {
  bool isLoad = true;
  final List<DestinationPost> _popularDestinationPost = [];
  final List<DestinationPost> _typeDestinationPost = [];

  VatractionUser? sharer;

  final List<Category> categories = [
    // Setting again in class SettingPostType => to setting title and intro to Category
    Category(
      icon: "assets/icons/ic_beach.svg",
      title: "Beach",
      thumb: ImageConfig.thumbBeach,
      intro: 'Khám Phá Biển',
      type: PostType.beach,
    ),
    Category(
      icon: "assets/icons/ic_mountain.svg",
      title: "Mountain",
      thumb: ImageConfig.thumbMountain,
      intro: 'Núi Non Hùng Vĩ',
      type: PostType.mountain,
    ),
    Category(
      icon: "assets/icons/ic_island.svg",
      title: "Island",
      thumb: ImageConfig.thumbIsland,
      intro: 'Vi Vu Đảo Ngọc',
      type: PostType.island,
    ),
    Category(
      icon: "assets/icons/ic_city.svg",
      title: "City",
      thumb: ImageConfig.thumbCity,
      intro: 'Khám Phá Phố Thị',
      type: PostType.city,
    ),
  ];

  DestinationPostProvider() {
    onDataChange();
  }

  void onDataChange() {
    DestinationPostRepo.onPostDataChange().listen((QuerySnapshot event) {
      for (var element in event.docChanges) {
        final post =
            DestinationPost.fromMap(element.doc.data() as Map<String, dynamic>);
        switch (element.type) {
          case DocumentChangeType.added:
            if (post.rating >= 3.5) {
              _popularDestinationPost.add(post);
            }
            break;
          case DocumentChangeType.modified:
            final index = _popularDestinationPost.indexWhere((element) =>
                element.destinationPostId == post.destinationPostId);
            if (index >= 0) {
              _popularDestinationPost[index] = post;
            }
            break;
          case DocumentChangeType.removed:
            _popularDestinationPost.removeWhere((element) =>
                element.destinationPostId == post.destinationPostId);
            break;
        }
      }
      notifyListeners();
    });
  }

  // void getPopularPost() async {
  //   var allPost = await PostRepo.getAllPost();
  //   for (Post e in allPost) {
  //     if (e.rating >= 3.5 && e.status == PostStatus.approve) {
  //       _popularPost.add(e);
  //     } else {
  //       continue;
  //     }
  //   }
  //   isLoad = false;
  //   notifyListeners();
  // }

  Future<void> getDestinationPostByType(PostType type) async {
    _typeDestinationPost.clear();
    var allPost = await DestinationPostRepo.getAllDestinationPost();
    for (DestinationPost e in allPost) {
      if (e.type == type && e.status == PostStatus.approve) {
        _typeDestinationPost.add(e);
      } else {
        continue;
      }
    }
    isLoad = false;
    notifyListeners();
  }

  List<DestinationPost> get popularDestinationPost {
    return _popularDestinationPost;
  }

  List<DestinationPost> get typeDestinationPost {
    return _typeDestinationPost;
  }

  Future<void> getUserById(String uid) async {
    sharer = await DestinationPostRepo.getUserById(uid);
  }
}
