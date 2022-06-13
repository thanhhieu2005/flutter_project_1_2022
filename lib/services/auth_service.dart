import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth_service;
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/app.dart';
import 'package:flutter_project_1/configs/app_config.dart';
import 'package:flutter_project_1/configs/auth_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  String _token = "";
  bool isloading = false;
  VatractionUser currentUser =
      const VatractionUser(email: "", uid: "", pwd: "");

  final auth_service.FirebaseAuth _firebaseAuth =
      auth_service.FirebaseAuth.instance;

  VatractionUser? _userFromFirebase(auth_service.User? user) {
    if (user == null) {
      return null;
    }
    return VatractionUser(uid: user.uid, email: user.email!, pwd: "");
  }

  Future getUserFromFirebase(String? uid) async {
    if (uid == null) {
      return null;
    }
    await FirebaseFirestore.instance.collection("Users").doc(uid).get().then(
          (DocumentSnapshot<Map<String, Object?>?> docSnapShot) => {
            if (docSnapShot.exists)
              {
                localCurrentUser = VatractionUser.fromJson(docSnapShot.data()!),
                currentUser = localCurrentUser
              }
          },
        );
    notifyListeners();
  }

  Stream<VatractionUser?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<VatractionUser?> signInWithEmailAndPassword(
      String email, String password) async {
    isloading = true;
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await getUserFromFirebase(credential.user?.uid);
      return _userFromFirebase(credential.user);
    } catch (err) {
      isloading = false;
      var errorMessage = err.toString().replaceRange(0, 14, '').split(']')[1];
      return Future.error(errorMessage);
    }
  }

  Future<VatractionUser?> createUserWithEmailAndPassword(
      String email, String password, String? userName, bool isMale) async {
    isloading = true;
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      localCurrentUser = VatractionUser(
        pwd: password,
        email: email,
        uid: credential.user?.uid ?? "",
        userName: userName,
        gender: isMale ? "Male" : "Female",
        avatarUrl: isMale
            ? "https://scienceoxford.com/wp-content/uploads/2018/03/avatar-male.jpg"
            : "https://www.kindpng.com/picc/m/378-3783625_avatar-woman-blank-avatar-icon-female-hd-png.png",
      );
      addUserDataToFirebase(localCurrentUser);
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

  void createUserInfo(String email, String userName, String pwd) {
    currentUser = VatractionUser(
        email: email,
        uid: "",
        userName: userName,
        pwd: pwd,
        isConfirmEmail: false);
    localCurrentUser = currentUser;
  }

  Future signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future addUserDataToFirebase(VatractionUser user) async {
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
          currentUser = VatractionUser.fromJson(userData);
        }
      }
    } catch (e) {
      debugPrint("Error fail to load user data");
    }
  }

  Future _authenticate(String email, String password, String urlSegment) async {
    var dio = Dio();
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${AppConfigs.webApiKey}';
    final response = await dio.post(
      url,
      data: {'email': email, 'password': password, 'returnSecureToken': true},
    );
    final responseData = response.data;
    _token = responseData['idToken'];
  }

  Future<bool> sendOtp(String email, bool? isForget) async {
    isForget ?? false;
    if (isForget != true) {
      emailAuth.config(remoteServerConfiguration);
      bool result = await emailAuth.sendOtp(recipientMail: email);
      if (result) {
        return true;
      }
      return false;
    } else {
      changePwdConfirm.config(remotePwdServerConfiguration);
      bool result = await changePwdConfirm.sendOtp(recipientMail: email);
      if (result) {
        return true;
      }
      return false;
    }
  }

  Future<bool> verifyOtp(
      String recipientMail, String userOtp, bool? isForget) async {
    isForget ?? false;
    bool result = false;
    if (isForget != true) {
      emailAuth.config(remoteServerConfiguration);
      isloading = true;
      result =
          emailAuth.validateOtp(recipientMail: recipientMail, userOtp: userOtp);
      if (result) {
        localCurrentUser = localCurrentUser.copyWith(isConfirmEmail: true);
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString("user", jsonEncode(localCurrentUser.toJson()));
      }
    } else {
      changePwdConfirm.config(remotePwdServerConfiguration);
      isloading = true;
      result = changePwdConfirm.validateOtp(
          recipientMail: recipientMail, userOtp: userOtp);
      if (result) {
        localCurrentUser = localCurrentUser.copyWith(isConfirmEmail: true);
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString("user", jsonEncode(localCurrentUser.toJson()));
      }
    }

    return result;
  }

  Future updateVerifyEmailStatus(String uid) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .update({'isConfirmEmail': true});
  }

  Future changePassword(String newPassword) async {
    await _authenticate(
        localCurrentUser.email, localCurrentUser.pwd, 'signInWithPassword');
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=${AppConfigs.webApiKey}';

    try {
      await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );
      localCurrentUser = localCurrentUser.copyWith(pwd: newPassword);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
      await updateUserPwdOnFirebase(newPassword, localCurrentUser.uid);
    } catch (error) {
      rethrow;
    }
  }

  Future<VatractionUser> getUserByEmail(String email) async {
    try {
      var collection = FirebaseFirestore.instance.collection("Users");
      var docSnapshot = await collection.where("email", isEqualTo: email).get();
      return VatractionUser.fromJson(docSnapshot.docs.first.data());
    } catch (err) {
      throw Exception(err);
    }
  }

  Future changePasswordWithoutLogin(String newPassword, String email) async {
    VatractionUser user = await getUserByEmail(email);
    await _authenticate(user.email, user.pwd, 'signInWithPassword');
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=${AppConfigs.webApiKey}';

    try {
      await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );
      localCurrentUser = user.copyWith(pwd: newPassword);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
      await updateUserPwdOnFirebase(newPassword, localCurrentUser.uid);
    } catch (error) {
      rethrow;
    }
  }

  Future updateUserPwdOnFirebase(String newPassword, String uid) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .update({'pwd': newPassword});
  }
}
