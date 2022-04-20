import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth_service;
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/models/user.dart';

class AuthService {
  String loginEmail = "",
      loginPassword = "",
      signUpEmail = "",
      signUpPassword = "",
      confirmPwd = "";
  bool isloading = false;
  User currentUser = User(uid: "", userName: "");

  final auth_service.FirebaseAuth _firebaseAuth =
      auth_service.FirebaseAuth.instance;
  User? _userFromFirebase(auth_service.User? user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    isloading = true;
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      clearTextController();
      return _userFromFirebase(credential.user);
    } catch (err) {
      isloading = false;
      var errorMessage = err.toString().replaceRange(0, 14, '').split(']')[1];
      return Future.error(errorMessage);
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    isloading = true;
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      addUserDataToFirebase(_userFromFirebase(credential.user)!);
      clearTextController();
      return _userFromFirebase(credential.user);
    } catch (err) {
      isloading = false;
      var errorMessage = err.toString().replaceRange(0, 14, '').split(']')[1];
      return Future.error(errorMessage);
    }
  }

  Future signOut() async {
    clearTextController();
    return await _firebaseAuth.signOut();
  }

  Future addUserDataToFirebase(User user) async {
    CollectionReference users = FirebaseFirestore.instance.collection("Users");
    users.doc(user.uid).set(user.toJson());
  }

  Future getCurrentUserInfo(String uid) async {
    try {
      var collection = FirebaseFirestore.instance.collection("Users");
      var docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? userData = docSnapshot.data();
        if (userData != null) {
          currentUser = User.fromJson(userData);
        }
      }
    } catch (e) {
      print("Error fail to load user data");
    }
  }

  void clearTextController() {
    loginEmail = "";
    loginPassword = "";
    signUpEmail = "";
    signUpPassword = "";
  }
}
