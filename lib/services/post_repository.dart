import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_1/models/posts/post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/account_repository.dart';
import 'package:path/path.dart';

class PostRepo {
  static final _collectionPost = FirebaseFirestore.instance.collection('Posts');

  static Stream<QuerySnapshot> onPostDataChange() {
    return _collectionPost.snapshots();
  }

  static getAllPost() async {
    List<Post> listAllPost = [];
    var snapshot = await FirebaseFirestore.instance.collection('Posts').get();

    listAllPost
        .addAll(snapshot.docs.map((e) => Post.fromMap(e.data())).toList());
    return listAllPost;
  }

  static getUserById(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data();
      return VatractionUser.fromJson(userData!);
    } else {
      return null;
    }
  }

  static getPostById(String postId) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('Posts').doc(postId).get();
    if (snapshot.exists) {
      Post post = Post.fromMap(snapshot.data()!);
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
          folderPath: namePost,
          fileName: basename(image.path),
          avatarFile: image,
        ),
      ),
    );
    return imageUrls;
  }

  Future<void> submitPost(Post newPost, String postId) async {
    await _collectionPost.doc(postId).set(newPost.toMap());
  }
}
