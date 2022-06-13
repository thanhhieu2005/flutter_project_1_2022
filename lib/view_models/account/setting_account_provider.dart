import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1/constants/global_constants.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/services/account_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      TextEditingController(text: localCurrentUser.phoneNumber);
  final TextEditingController dOBController =
      TextEditingController(text: localCurrentUser.dateOfBirth);
  final TextEditingController addressController =
      TextEditingController(text: localCurrentUser.address);

  late File _avatar = File('');

  bool _isLoad = false;

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  File get avatar {
    return _avatar;
  }

  Future<void> refeshInput() async {
    userNameController.text = localCurrentUser.userName!;
    phoneNumController.text = localCurrentUser.phoneNumber!;
    dOBController.text = localCurrentUser.dateOfBirth!;
    addressController.text = localCurrentUser.address!;
    notifyListeners();
  }

  VatractionUser infoUserUpdate(String newAvatar) {
    var newInfoUser = VatractionUser(
      role: localCurrentUser.role,
      avatarUrl: newAvatar,
      uid: localCurrentUser.uid,
      email: localCurrentUser.email,
      pwd: localCurrentUser.pwd,
      dateOfBirth: dOBController.text,
      userName: userNameController.text,
      isConfirmEmail: localCurrentUser.isConfirmEmail,
      phoneNumber: phoneNumController.text,
      address: addressController.text,
    );
    return newInfoUser;
  }

  Future<void> updateInfoUser(Function onSuccess, Function onFail) async {
    if (userNameController.text.isEmpty) {
      onFail();
    } else {
      isLoad = true;
      var newInfoUser = infoUserUpdate(localCurrentUser.avatarUrl!);
      await AccountRepo.updateInfoUser(newInfoUser);
      _currUser = newInfoUser;
      localCurrentUser = newInfoUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(localCurrentUser.toJson()));
      prefs.getString("user");
      isLoad = false;
      onSuccess();
    }
  }

  VatractionUser getCurrUser() {
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
}
