import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth_service;
import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/configs/app_config.dart';
import 'package:flutter_project_1/configs/auth_config.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  String _token = "";
  bool isloading = false;
  VatractionUser currentUser =
      const VatractionUser(email: "", uid: "", pwd: "");

  late EmailAuth emailAuth;

  AuthService() {
    emailAuth = EmailAuth(sessionName: "VAtraction");
  }

  final auth_service.FirebaseAuth _firebaseAuth =
      auth_service.FirebaseAuth.instance;

  get http => null;
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
    emailAuth.config(remoteServerConfiguration);
    bool result = await emailAuth.sendOtp(recipientMail: email);
    if (result) {
      return true;
    }
    return false;
  }

  Future<bool> verifyOtp(String recipientMail, String userOtp) async {
    emailAuth.config(remoteServerConfiguration);
    isloading = true;
    bool result =
        emailAuth.validateOtp(recipientMail: recipientMail, userOtp: userOtp);
    if (result) {
      localCurrentUser = localCurrentUser.copyWith(isConfirmEmail: true);
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString("user", jsonEncode(localCurrentUser.toJson()));
    }
    return result;
  }

  Future updateVerifyEmailStatus(String uid) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .update({'isConfirmEmail': true});
  }
}
