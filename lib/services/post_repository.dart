import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project_1/models/posts/post.dart';
import 'package:flutter_project_1/models/users/user.dart';

class PostRepo {
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
}
