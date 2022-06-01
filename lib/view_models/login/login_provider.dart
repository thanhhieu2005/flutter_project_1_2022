import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/global_constants.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  final loginEmailController = TextEditingController();
  final loginPwdController = TextEditingController();

  void clearTextController() {
    loginEmailController.clear();
    loginPwdController.clear();
    notifyListeners();
  }

  Future<bool> signInWithEmail() async {
    isLoading = true;
    try {
      await AuthService().signInWithEmailAndPassword(
          loginEmailController.text, loginPwdController.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
      if (!localCurrentUser.isConfirmEmail) {
        return false;
      }
    } catch (err) {
      isLoading = false;
      throw Exception(err.toString());
    }
    isLoading = false;
    notifyListeners();
    return true;
  }

  void autoFillText(String? email, String? pwd) {
    if (email != null && pwd != null) {
      loginEmailController.text = email;
      loginPwdController.text = pwd;
    }
  }
}