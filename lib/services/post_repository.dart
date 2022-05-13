import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_1/models/post.dart';

class PostRepo {
  static getAllPost() async {
    List<Post> listAllPost = [];
    var snapshot = await FirebaseFirestore.instance.collection('Posts').get();

    listAllPost
        .addAll(snapshot.docs.map((e) => Post.fromMap(e.data())).toList());
    return listAllPost;
  }
}
