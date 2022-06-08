import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/favorite_post.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/services/destination_post_repository.dart';

class PostDetailProvider extends ChangeNotifier {
  double? _ratingValue;

  late FavoriteDestinationPost favoriteDestinationPost;

  set ratingValue(value) {
    _ratingValue = value;
    notifyListeners();
  }

  double? get ratingValue => _ratingValue;

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
