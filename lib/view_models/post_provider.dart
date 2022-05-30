import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/configs/image_config.dart';
import 'package:flutter_project_1/models/others/category_model.dart';
import 'package:flutter_project_1/models/posts/post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/post_repository.dart';

class PostProvider extends ChangeNotifier {
  bool isLoad = true;
  final List<Post> _popularPost = [];
  final List<Post> _typePost = [];
  VatractionUser? sharer;

  final List<Category> categories = [
    Category(
      icon: "assets/icons/ic_beach.svg",
      title: "Beach",
      thumb: ImageConfig.thumbBeach,
      intro: 'Khám Phá Biển',
      type: 1,
    ),
    Category(
      icon: "assets/icons/ic_mountain.svg",
      title: "Mountain",
      thumb: ImageConfig.thumbMountain,
      intro: 'Núi Non Hùng Vĩ',
      type: 2,
    ),
    Category(
      icon: "assets/icons/ic_island.svg",
      title: "Island",
      thumb: ImageConfig.thumbIsland,
      intro: 'Vi Vu Đảo Ngọc',
      type: 3,
    ),
    Category(
      icon: "assets/icons/ic_city.svg",
      title: "City",
      thumb: ImageConfig.thumbCity,
      intro: 'Khám Phá Phố Thị',
      type: 4,
    ),
  ];

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

  Future<void> getPostByType(int findType) async {
    _typePost.clear();
    var allPost = await PostRepo.getAllPost();
    for (Post e in allPost) {
      if (e.type == findType) {
        _typePost.add(e);
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

  List<Post> get typePost {
    return _typePost;
  }

  Future<void> getUserById(String uid) async {
    sharer = await PostRepo.getUserById(uid);
  }
}
