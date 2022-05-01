import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';

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
      if (!AuthService().currentUser.isConfirmEmail) {
        return false;
      }
    } catch (err) {
      throw Exception(err.toString());
    }
    return true;
  }
}
