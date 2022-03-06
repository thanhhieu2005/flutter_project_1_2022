import 'package:firebase_auth/firebase_auth.dart' as auth_service;
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/models/user.dart';

class AuthService {
  String loginEmail = "",
      loginPassword = "",
      signUpEmail = "",
      signUpPassword = "";
  bool isloading = false;

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
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future signOut() async {
    return await _firebaseAuth.signOut();
  }
}
