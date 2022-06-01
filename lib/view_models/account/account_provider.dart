import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/users/user.dart';

class AccountProvider extends ChangeNotifier {
  final _currUser = localCurrentUser;
  final TextEditingController userNameController =
      TextEditingController(text: localCurrentUser.userName);
  final TextEditingController emailController =
      TextEditingController(text: localCurrentUser.email);
  final TextEditingController phoneNumController =
      TextEditingController(text: "");
  final TextEditingController dOBController =
      TextEditingController(text: localCurrentUser.dateOfBirth);
  final TextEditingController addressController =
      TextEditingController(text: "");

  VatractionUser infoUserUpdate() {
    var newInfoUser = VatractionUser(
        uid: localCurrentUser.uid,
        email: localCurrentUser.email,
        pwd: localCurrentUser.pwd,
        dateOfBirth: dOBController.text,
        userName: userNameController.text);
    return newInfoUser;
  }

  VatractionUser getCurrUser() {
    return _currUser;
  }
}
