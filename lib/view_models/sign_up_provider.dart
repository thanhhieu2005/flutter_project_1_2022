import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';

class SignUpProvider extends ChangeNotifier {
  final pwdController = TextEditingController();
  final pwdConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final pinCodeController = TextEditingController();

  Future createAccountWithEmail() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
          emailController.text, pwdController.text);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  void createLocalUser() {
    AuthService().createLocalUser(
        emailController.text, userNameController.text, pwdController.text);
  }

  Future sendOtp() async {
    try {
      await AuthService().sendOtp(emailController.text);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  bool verifyOtp() {
    try {
      return AuthService()
          .verifyOtp(emailController.text, pinCodeController.text);
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
