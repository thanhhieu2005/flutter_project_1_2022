import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/account_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SettingAccountProvider extends ChangeNotifier {
  final currentHour = DateTime.now().hour;
  var _currUser = localCurrentUser;
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

  final TextEditingController currentPwdController = TextEditingController();
  final TextEditingController newPwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  late File _avatar = File('');

  bool _isLoad = false;

  bool get isLoad => _isLoad;

  bool isLoadChangePwd = false;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  File get avatar {
    return _avatar;
  }

  Future<void> refeshInput() async {
    userNameController.text = localCurrentUser.userName!;
    phoneNumController.text = "";
    dOBController.text = localCurrentUser.dateOfBirth!;
    addressController.text = "";
    notifyListeners();
  }

  VatractionUser infoUserUpdate(String newAvatar) {
    var newInfoUser = VatractionUser(
        avatarUrl: newAvatar,
        uid: localCurrentUser.uid,
        email: localCurrentUser.email,
        pwd: localCurrentUser.pwd,
        dateOfBirth: dOBController.text,
        userName: userNameController.text,
        isConfirmEmail: localCurrentUser.isConfirmEmail);
    return newInfoUser;
  }

  Future<void> updateInfoUser(Function onSuccess, Function onFail) async {
    if (userNameController.text.isEmpty ||
        userNameController.text == localCurrentUser.userName) {
      onFail();
    } else {
      isLoad = true;
      var newInfoUser = infoUserUpdate(localCurrentUser.avatarUrl!);
      await AccountRepo.updateInfoUser(newInfoUser);
      _currUser = newInfoUser;
      localCurrentUser = newInfoUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
      isLoad = false;
      onSuccess();
    }
  }

  VatractionUser getCurrUser() {
    localCurrentUser;
    return _currUser;
  }

  String setUpTimezone(BuildContext context) {
    var timeZone = currentHour >= 5 && currentHour <= 11
        ? AppLocalizations.of(context).goodMorning
        : currentHour > 11 && currentHour < 19
            ? AppLocalizations.of(context).goodAfternoon
            : AppLocalizations.of(context).goodEvening;

    return timeZone;
  }

  String setUpDisplayName() {
    var _user = getCurrUser();
    var displayName = _user.userName!.split(" ");
    if (" ".allMatches(_user.userName.toString()).isNotEmpty) {
      return displayName.last;
    } else {
      return _user.userName!;
    }
  }

  Future<void> refreshFile() async {
    _avatar = File('');
    notifyListeners();
  }

  Future selectFile() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporagy = File(image.path);
      _avatar = imageTemporagy;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Fail to pick image: $e");
    }
  }

  Future<void> saveAvatar(Function onSuccess, Function onFail) async {
    if (_avatar.path == '') {
      onFail();
    } else {
      isLoad = true;
      final newAvatarUrl = await AccountRepo.uploadFile(
        avatarFile: File(avatar.path),
        fileName: basename(avatar.path),
        folderPath: 'avatar_photos',
        folderName: _currUser.uid,
      );

      var newInfoUser = infoUserUpdate(newAvatarUrl);
      _currUser = newInfoUser;
      localCurrentUser = newInfoUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
      await AccountRepo.updateInfoUser(_currUser);
      _avatar = File('');

      isLoad = false;

      onSuccess();
    }
  }

  void setCurrentUser() {
    _currUser = localCurrentUser;
  }

  Future changePassword() async {
    if (isValidPwd()) {
      isLoadChangePwd = true;
      try {
        await AuthService().changePassword(newPwdController.text);
      } catch (err) {
        throw Exception(err);
      }
    } else {
      throw Exception("Can not change your password, Please try again");
    }
    isLoadChangePwd = false;
    notifyListeners();
  }

  bool isValidPwd() {
    return currentPwdController.text == localCurrentUser.pwd &&
        newPwdController.text == confirmPwdController.text &&
        currentPwdController.text != newPwdController.text;
  }

  void clearTextController() {
    currentPwdController.clear();
    newPwdController.clear();
    confirmPwdController.clear();
  }
}
