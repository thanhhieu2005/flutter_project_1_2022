import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';

class SearchPostProvider extends ChangeNotifier {
  final List<DestinationPost> _listPostModeration = [];

  VatractionUser? sharer;

  bool isDispose = false;

  List<DestinationPost> _listPosts = [];

  List<DestinationPost> get listPosts {
    return _listPosts;
  }

  SearchPostProvider();

  List<DestinationPost> get listPostModeration {
    _listPostModeration.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return _listPostModeration;
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
        if (post.status == PostStatus.approve) {
          _listPostModeration.add(post);
        }
      }
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
}
