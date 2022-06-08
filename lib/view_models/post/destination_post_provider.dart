import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/configs/image_config.dart';
import 'package:flutter_project_1/models/others/category_model.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';

class DestinationPostProvider extends ChangeNotifier {
  bool _isLoad = true;
  final List<DestinationPost> _popularDestinationPost = [];
  final List<DestinationPost> _typeDestinationPost = [];

  VatractionUser? sharer;

  bool isDispose = false;

  double? _ratingValue;

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

  DestinationPostProvider();

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  set ratingValue(value) {
    _ratingValue = value;
    notifyListeners();
  }

  double? get ratingValue => _ratingValue;

  void onDataChange() {
    DestinationPostRepo.onPostDataChange().listen((QuerySnapshot event) {
      if (isDispose == true) return;
      for (var element in event.docChanges) {
        final post =
            DestinationPost.fromMap(element.doc.data() as Map<String, dynamic>);
        switch (element.type) {
          add:
          case DocumentChangeType.added:
            if (post.rating >= 3.5 && post.status == PostStatus.approve) {
              _popularDestinationPost.add(post);
            }
            break;
          case DocumentChangeType.modified:
            if (post.status != PostStatus.approve || post.rating < 3.5) {
              continue remove;
            }
            final index = _popularDestinationPost.indexWhere((element) =>
                element.destinationPostId == post.destinationPostId);
            if (index >= 0) {
              _popularDestinationPost[index] = post;
            } else {
              continue add;
            }
            break;
          remove:
          case DocumentChangeType.removed:
            _popularDestinationPost.removeWhere((element) =>
                element.destinationPostId == post.destinationPostId);

            break;
        }
      }
      notifyListeners();
    });
  }

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

  void evaluationDestinationPost(DestinationPost post) async {
    var sumPointRating = post.rating * post.countRating;
    var newPointRating = (sumPointRating + ratingValue!);
    double newRating = double.parse(
        ((newPointRating) / (post.countRating + 1)).toStringAsFixed(1));

    await DestinationPostRepo()
        .evaluatePost(post.destinationPostId, newRating, post.countRating + 1);
    notifyListeners();
  }
}
