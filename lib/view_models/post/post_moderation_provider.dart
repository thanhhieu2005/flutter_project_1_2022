import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';
import 'package:tiengviet/tiengviet.dart';

class PostModerationProvider extends ChangeNotifier {
  final List<DestinationPost> _listPostModeration = [];

  List<DestinationPost> _listSearch = [];

  VatractionUser? sharer;

  bool isDispose = false;

  PostModerationProvider();

  List<DestinationPost> get listPostModeration {
    _listPostModeration.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return _listPostModeration;
  }

  List<DestinationPost> get listPostSearch {
    _listSearch.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return _listSearch;
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
              _listPostModeration.add(post);
            }
            break;
          case DocumentChangeType.modified:
            if (post.status != PostStatus.pending) {
              continue remove;
            }
            final index = _listPostModeration.indexWhere((element) =>
                element.destinationPostId == post.destinationPostId);
            if (index >= 0) {
              _listPostModeration[index] = post;
            }
            break;
          remove:
          case DocumentChangeType.removed:
            if (post.status != PostStatus.pending) {
              _listPostModeration.removeWhere((element) =>
                  element.destinationPostId == post.destinationPostId);
            }

            break;
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
