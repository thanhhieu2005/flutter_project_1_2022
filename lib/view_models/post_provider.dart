import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/models/post.dart';
import 'package:flutter_project_1/services/post_repository.dart';

class PostProvider extends ChangeNotifier {
  bool isLoad = true;
  final List<Post> _popularPost = [];

  PostProvider() {
    getPopularPost();
  }

  void getPopularPost() async {
    var allPost = await PostRepo.getAllPost();
    for (Post e in allPost) {
      if (e.rating >= 3.5) {
        _popularPost.add(e);
      } else {
        continue;
      }
    }
    isLoad = false;
    notifyListeners();
  }

  List<Post> get popularPost {
    return _popularPost;
  }
}
