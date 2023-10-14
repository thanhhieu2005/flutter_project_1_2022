import 'dart:convert';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project_1/app.dart';
import 'package:flutter_project_1/configs/auth_config.dart';
import 'package:flutter_project_1/configs/color_config.dart';
import 'package:flutter_project_1/view_models/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/global_constants.dart';
import 'models/users/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  Map<String, dynamic> userJson = {};
  if (pref.getString('user') != null) {
    userJson = jsonDecode(pref.getString('user')!);
    localCurrentUser = VatractionUser.fromJson(userJson);
  }
  emailAuth = EmailAuth(sessionName: "VAttraction");
  emailAuth.config(remoteServerConfiguration);
  changePwdConfirm = EmailAuth(sessionName: "VAttraction");
  changePwdConfirm.config(remotePwdServerConfiguration);
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VAtractionApp();
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.kPrimaryColor
    ..backgroundColor = Colors.black.withOpacity(0.2)
    ..indicatorColor = AppColors.kPrimaryColor
    ..textColor = AppColors.kPrimaryColor
    ..maskColor = AppColors.kPrimaryColor.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
