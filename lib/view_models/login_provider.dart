import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';

import '../constants/global_constants.dart';

class LoginProvider extends ChangeNotifier {
  final loginEmailController = TextEditingController();
  final loginPwdController = TextEditingController();

  void clearTextController() {
    loginEmailController.clear();
    loginPwdController.clear();
    notifyListeners();
  }

  Future<bool> signInWithEmail() async {
    try {
      await AuthService().signInWithEmailAndPassword(
          loginEmailController.text, loginPwdController.text);
      if (!localCurrentUser.isConfirmEmail) {
        return false;
      }
    } catch (err) {
      globalIsLoading = false;
      throw Exception(err.toString());
    }
    globalIsLoading = false;
    return true;
  }

  void autoFillText(String? email, String? pwd) {
    if (email != null && pwd != null) {
      loginEmailController.text = email;
      loginPwdController.text = pwd;
    }
  }
}
