import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/global_constants.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isEnterEmail = false;
  bool _isChangePwd = false;
  bool _isLoadingPwd = false;
  final loginEmailController = TextEditingController();
  final loginPwdController = TextEditingController();
  final forgetPwdPinController = TextEditingController();
  final forgetEmailController = TextEditingController();
  final newPwdController = TextEditingController();

  void clearTextController() {
    loginEmailController.text = "";
    loginPwdController.text = "";
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isEnterEmail => _isEnterEmail;

  set isEnterEmail(value) {
    _isEnterEmail = value;
    notifyListeners();
  }

  bool get isChangePwd => _isChangePwd;

  set isChangePwd(value) {
    _isChangePwd = value;
    notifyListeners();
  }

  bool get isLoadingPwd => _isLoadingPwd;

  set isLoadingPwd(value) {
    _isLoadingPwd = value;
    notifyListeners();
  }

  Future clearForgetPwdPage() async {
    isChangePwd = false;
    isEnterEmail = false;
    isLoadingPwd = false;
    forgetEmailController.text = "";
    forgetPwdPinController.clear();
    newPwdController.clear();
    notifyListeners();
  }

  Future<bool> signInWithEmail() async {
    isLoading = true;
    try {
      await AuthService().signInWithEmailAndPassword(
          loginEmailController.text, loginPwdController.text);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
      if (!localCurrentUser.isConfirmEmail!) {
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

  Future sendOtp(String email) async {
    try {
      await AuthService().sendOtp(email, true);
      isEnterEmail = true;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> verifyOtp(String email, String userOtp) async {
    var result = false;
    try {
      result = await AuthService().verifyOtp(email, userOtp, true);
    } catch (err) {
      throw Exception(err);
    }
    return result;
  }

  Future<bool> changePwd(String pwd, String email) async {
    var isChangePwdSuccess = false;
    try {
      await AuthService().changePasswordWithoutLogin(pwd, email);
      isChangePwdSuccess = true;
    } catch (err) {
      throw Exception(err);
    }
    return isChangePwdSuccess;
  }
}
