import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/global_constants.dart';

class SignUpProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isCheckPolicy = false;
  final pwdController = TextEditingController();
  final pwdConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final pinCodeController = TextEditingController();

  Future createAccountWithEmail() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
          emailController.text, pwdController.text, userNameController.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
    } catch (err) {
      isLoading = false;
      notifyListeners();
      throw Exception(err.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  void setLoadingStatus(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  bool getCheckPolicyStatus() {
    return isCheckPolicy;
  }

  void setCheckPolicyStatus(bool status) {
    isCheckPolicy = status;
  }

  void createLocalUser() {
    AuthService().createUserInfo(
        emailController.text, userNameController.text, pwdController.text);
  }

  bool isValidForSendingOtp() {
    isLoading = true;
    notifyListeners();
    var result = emailController.text.isNotEmpty &&
        pwdController.text.isNotEmpty &&
        pwdConfirmController.text.isNotEmpty &&
        userNameController.text.isNotEmpty &&
        pwdController.text == pwdConfirmController.text &&
        userNameController.text.length >= 6 &&
        pwdConfirmController.text.length >= 6 &&
        pwdController.text.length >= 6 &&
        isCheckPolicy == true;
    if (!result) {
      isLoading = false;
      notifyListeners();
    }
    return result;
  }

  Future sendOtp() async {
    isLoading = true;
    try {
      await AuthService().sendOtp(emailController.text);
      isLoading = false;
    } catch (err) {
      isLoading = false;
      throw Exception(err.toString());
    }
  }

  void clearTextController() {
    pwdController.text = "";
    pwdConfirmController.clear();
    emailController.clear();
    userNameController.clear();
  }

  void clearPinCodeController() {
    pinCodeController.clear();
    isLoading = false;
    notifyListeners();
  }

  Future updateVerifyEmailStatus(String uid) async {
    try {
      await AuthService().updateVerifyEmailStatus(uid);
    } catch (err) {
      throw Exception(err);
    }
  }
}
