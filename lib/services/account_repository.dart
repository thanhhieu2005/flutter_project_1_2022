import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project_1/models/users/user.dart';

class AccountRepo {
  static final _collectionFavorite =
      FirebaseFirestore.instance.collection('Favorites');

  static Stream<QuerySnapshot> onPostDataChange() {
    return _collectionFavorite.snapshots();
  }

  static Future<void> updateInfoUser(VatractionUser newInfoUser) async {
    var docs = FirebaseFirestore.instance.collection("Users");

    await docs.doc(newInfoUser.uid).update({
      "avatarUrl": newInfoUser.avatarUrl,
      "userName": newInfoUser.userName,
      "dateOfBirth": newInfoUser.dateOfBirth
    });
  }

  static Future<String> uploadFile(
      {required String folderPath,
      required String fileName,
      required String folderName,
      required File avatarFile}) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child(folderPath)
        .child(folderName)
        .child(fileName);

    UploadTask uploadTask = ref.putFile(avatarFile);
    var snapshot = await uploadTask.whenComplete(() => {});
    var urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}
