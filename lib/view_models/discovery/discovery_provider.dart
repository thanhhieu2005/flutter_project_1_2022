import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../configs/image_config.dart';
import '../../models/others/category_model.dart';

class DiscoveryProvider extends ChangeNotifier {
  final List<DestinationPost> _listPost = [];

  List<DestinationPost> _listSearch = [];

  List<DestinationPost> _typeList = [];

  VatractionUser? sharer;

  bool isDispose = false;

  DiscoveryProvider();

  List<DestinationPost> get listPostModeration {
    _listPost.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return _listPost;
  }

  List<DestinationPost> get listPostSearch {
    _listSearch.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return _listSearch;
  }

  List<DestinationPost> get typeList {
    _typeList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return _typeList;
  }

  void onDataChange() {
    DestinationPostRepo.onPostDataChange().listen((QuerySnapshot event) {
      if (isDispose == true) return;
      for (var element in event.docChanges) {
        final post =
            DestinationPost.fromMap(element.doc.data() as Map<String, dynamic>);
        switch (element.type) {
          case DocumentChangeType.added:
            if (post.status == PostStatus.pending) {
              _listPost.add(post);
            }
            break;
          case DocumentChangeType.modified:
            if (post.status != PostStatus.pending) {
              continue remove;
            }
            final index = _listPost.indexWhere((element) =>
                element.destinationPostId == post.destinationPostId);
            if (index >= 0) {
              _listPost[index] = post;
            }
            break;
          remove:
          case DocumentChangeType.removed:
            if (post.status != PostStatus.pending) {
              _listPost.removeWhere((element) =>
                  element.destinationPostId == post.destinationPostId);
            }

            break;
        }
      }
      _listSearch = _listPost;
      notifyListeners();
    });
  }

  Future<void> getUserById(String uid) async {
    sharer = await DestinationPostRepo.getUserById(uid);
  }

  void postModeration(
      String postId, PostStatus postStatus, Function onSuccess) async {
    await DestinationPostRepo().postModeration(postId, postStatus.value);
    onSuccess();
    notifyListeners();
  }

  void onSearch(String keyword) {
    _listSearch = _listPost
        .where((post) => TiengViet.parse(post.postName.toLowerCase())
            .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> getDestinationPostByType(PostType type) async {
    _typeList.clear();
    var allPost = await DestinationPostRepo.getAllDestinationPost();
    for (DestinationPost e in allPost) {
      if (e.type == type && e.status == PostStatus.approve) {
        _typeList.add(e);
      } else {
        continue;
      }
    }
    notifyListeners();
  }

  final List<Category> categories = [
    // Setting again in class SettingPostType => to setting title and intro to Category
    Category(
        icon: "assets/icons/summer.png",
        title: "Summer",
        thumb: ImageConfig.thumbSummer,
        intro: "Discover some of the best tourist attraction in the hot Summer",
        type: PostType.summer,
        subtitle:
            "Discover some of the best tourist attraction in the hot Summer"),
    Category(
        icon: "assets/icons/happyWeekend.png",
        title: "Happy Weekend",
        thumb: ImageConfig.thumbHappyWeekend,
        intro: "Let's hangout in some of the amazing places for the weekend",
        type: PostType.happyWeekend,
        subtitle:
            "Let's hangout in some of the amazing places for the weekend"),
    Category(
        icon: "assets/icons/wild.png",
        title: "Wild",
        thumb: ImageConfig.thumbWild,
        intro: "Let's join into the wild and be a part of it",
        type: PostType.wild,
        subtitle: "Let's join into the wild and be a part of it"),

    Category(
        icon: "assets/icons/other.png",
        title: "Other",
        thumb: ImageConfig.thumbOther,
        intro: "Let's discover and learn more about new interesting cultures",
        type: PostType.other,
        subtitle:
            "Let's discover and learn more about new interesting cultures"),
  ];
}
