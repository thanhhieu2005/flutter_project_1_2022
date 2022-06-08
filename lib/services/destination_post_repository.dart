import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_1/models/favorite_post.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/account_repository.dart';
import 'package:path/path.dart';

class DestinationPostRepo {
  static final _collectionPost = FirebaseFirestore.instance.collection('Posts');
  static final _collectionFavorite =
      FirebaseFirestore.instance.collection('Favorites');

  static Stream<QuerySnapshot> onPostDataChange() {
    return _collectionPost.snapshots();
  }

  static getAllDestinationPost() async {
    List<DestinationPost> listAllDestinationPost = [];
    var snapshot = await FirebaseFirestore.instance.collection('Posts').get();

    listAllDestinationPost.addAll(
        snapshot.docs.map((e) => DestinationPost.fromMap(e.data())).toList());
    return listAllDestinationPost;
  }

  static getUserById(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data();
      var user = VatractionUser.fromJson(userData!);
      return user;
    } else {
      return null;
    }
  }

  static getPostById(String postId) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('Posts').doc(postId).get();
    if (snapshot.exists) {
      DestinationPost post = DestinationPost.fromMap(snapshot.data()!);
      return post;
    } else {
      return null;
    }
  }

  Future<List<String>> uploadListFileImage(
      List<File> _listImages, String namePost) async {
    var imageUrls = await Future.wait(
      _listImages.map(
        (image) => AccountRepo.uploadFile(
          folderName: namePost,
          folderPath: 'images_post',
          fileName: basename(image.path),
          avatarFile: image,
        ),
      ),
    );
    return imageUrls;
  }

  Future<void> submitPost(DestinationPost newPost, String postId) async {
    await _collectionPost.doc(postId).set(newPost.toMap());
  }

  Future<void> postModeration(String postId, int numStatus) async {
    await _collectionPost.doc(postId).update({
      "status": numStatus,
    });
  }

  Future<void> evaluatePost(
      String destinationPostId, double rating, int countRating) async {
    await _collectionPost.doc(destinationPostId).update({
      "rating": rating,
      "countRating": countRating,
    });
  }

  Future<FavoriteDestinationPost> setUpFavoriteFoodByUserId(
      String userId) async {
    FavoriteDestinationPost favoriteDestinationPost;
    var snapshot = await _collectionFavorite.doc(userId).get();
    if (snapshot.exists) {
      favoriteDestinationPost =
          FavoriteDestinationPost.fromMap(snapshot.data()!);
    } else {
      favoriteDestinationPost = FavoriteDestinationPost(
        userId: userId,
        listIdDestinantionPost: [],
      );

      await _collectionFavorite
          .doc(userId)
          .set(favoriteDestinationPost.toMap());
    }
    return favoriteDestinationPost;
  }

  Future<List<DestinationPost>> getListDestinationPostFavorite(
      FavoriteDestinationPost favoriteDestinationPost) async {
    List<DestinationPost> listFavorite = [];
    if (favoriteDestinationPost.listIdDestinantionPost.isNotEmpty) {
      var snapshot = await _collectionPost
          .where("postId",
              whereIn: favoriteDestinationPost.listIdDestinantionPost)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var element in snapshot.docs) {
          listFavorite.add(DestinationPost.fromMap(element.data()));
        }
      }
    }
    return listFavorite;
  }

  Future updateFavoritePost(
      FavoriteDestinationPost favoriteDestinationPost) async {
    await _collectionFavorite.doc(favoriteDestinationPost.userId).update({
      "listIdDestinantionPost": favoriteDestinationPost.listIdDestinantionPost
    });
  }
}
