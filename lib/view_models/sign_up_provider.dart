import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';

class SignUpProvider extends ChangeNotifier {
  final pwdController = TextEditingController();
  final pwdConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();

  Future createAccountWithEmail() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
          emailController.text, pwdController.text);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  void clearTextController() {
    pwdController.text = "";
    pwdConfirmController.clear();
    emailController.clear();
    userNameController.clear();
  }
}
