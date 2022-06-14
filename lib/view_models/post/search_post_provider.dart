import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';
import 'package:tiengviet/tiengviet.dart';

class SearchPostProvider extends ChangeNotifier {
  final List<DestinationPost> _listPostModeration = [];
  List<DestinationPost> _listSearch = [];

  bool _isModeration = false;

  VatractionUser? sharer;

  bool isDispose = false;

  List<DestinationPost> _listPosts = [];

  List<DestinationPost> get listPosts {
    return _listPosts;
  }

  bool get isModeration => _isModeration;

  set isModeration(value) {
    _isModeration = value;
    notifyListeners();
  }

  SearchPostProvider();

  List<DestinationPost> get listPostModeration {
    _listPostModeration.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return _listPostModeration;
  }

  List<DestinationPost> get listSearchPost {
    _listSearch.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    if (isModeration) {
      _listSearch = _listSearch
          .where((element) => element.status == PostStatus.pending)
          .toList();
    } else {
      _listSearch = _listSearch
          .where((element) => element.status == PostStatus.approve)
          .toList();
    }
    return _listSearch;
  }

  void clearListPost() {
    _listPostModeration.clear();
  }

  void onDataChange() {
    DestinationPostRepo.onPostDataChange().listen((QuerySnapshot event) {
      if (isDispose == true) return;
      for (var element in event.docChanges) {
        final post =
            DestinationPost.fromMap(element.doc.data() as Map<String, dynamic>);
        if (post.status == PostStatus.approve ||
            post.status == PostStatus.pending) {
          _listPostModeration.add(post);
        }
      }
      _listSearch = _listPostModeration;
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
    _listSearch = _listPostModeration
        .where((post) => TiengViet.parse(post.postName.toLowerCase())
            .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
