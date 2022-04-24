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

  Future signInWithEmail() async {
    try {
      await AuthService().signInWithEmailAndPassword(
          loginEmailController.text, loginPwdController.text);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
