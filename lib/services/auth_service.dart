import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth_service;
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/configs/app_config.dart';
import 'package:flutter_project_1/models/user.dart';
import 'package:flutter_project_1/view_models/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String _token = "";
  bool isloading = false;
  User currentUser = User(uid: "", userName: "");

  final auth_service.FirebaseAuth _firebaseAuth =
      auth_service.FirebaseAuth.instance;

  get http => null;
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
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      addUserDataToFirebase(_userFromFirebase(credential.user)!);
      return _userFromFirebase(credential.user);
    } on auth_service.FirebaseAuthException catch (err) {
      isloading = false;
      var errorMessage = err.toString().replaceRange(0, 14, '').split(']')[1];
      return Future.error(errorMessage);
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }

  Future signOut() async {
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
      debugPrint("Error fail to load user data");
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final url =
        'https://identitytoolkit..com/v1/accounts:$urlSegment?key=${AppConfigs.webApiKey}';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    debugPrint(responseData);
    _token = responseData['idToken'];
    debugPrint('************************' + _token.toString());
    try {
      if (urlSegment == "signUp") {
        sharedPreferences.setString("token", _token.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint("true");
  }

  Future<bool> sendOtp(String email) async {
    final emailAuth = EmailAuth(sessionName: "VAtraction");
    bool result = await emailAuth.sendOtp(recipientMail: email);
    if (result) {
      return true;
    }
    return false;
  }
}
