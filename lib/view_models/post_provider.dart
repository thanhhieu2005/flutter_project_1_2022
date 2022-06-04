import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/configs/image_config.dart';
import 'package:flutter_project_1/models/others/category_model.dart';
import 'package:flutter_project_1/models/posts/post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/post_repository.dart';

class PostProvider extends ChangeNotifier {
  bool isLoad = true;
  final List<Post> _popularPost = [];
  final List<Post> _fivePopularPost = [];
  final List<Post> _typePost = [];

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

  PostProvider() {
    getPopularPost();
    get5Popular();
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

  void get5Popular() async {
    var allPost = await PostRepo.getAllPost();
    for (Post e in allPost) {
      if (e.rating >= 3.5) {
        _fivePopularPost.add(e);
      } else {
        continue;
      }
    }
    _fivePopularPost.take(5);
    isLoad = false;
    notifyListeners();
  }

  Future<void> getPostByType(PostType type) async {
    _typePost.clear();
    var allPost = await PostRepo.getAllPost();
    for (Post e in allPost) {
      if (e.type == type) {
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

  List<Post> get fivePopularPost {
    return _fivePopularPost;
  }

  List<Post> get typePost {
    return _typePost;
  }

  Future<void> getUserById(String uid) async {
    sharer = await PostRepo.getUserById(uid);
  }
}
