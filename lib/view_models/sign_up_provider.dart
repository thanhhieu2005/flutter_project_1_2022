import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/services/auth_service.dart';

import '../constants/global_constants.dart';

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
      globalIsLoading = false;
      throw Exception(err.toString());
    }
    globalIsLoading = false;
  }

  void createLocalUser() {
    AuthService().createUserInfo(
        emailController.text, userNameController.text, pwdController.text);
  }

  Future sendOtp() async {
    try {
      await AuthService().sendOtp(emailController.text);
    } catch (err) {
      globalIsLoading = false;
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
  }
}
