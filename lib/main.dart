import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/app.dart';
import 'package:flutter_project_1/configs/auth_config.dart';
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
  emailAuth.config(remoteServerConfiguration);
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VAtractionApp();
  }
}
