import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/views/home_screen.dart';
import 'package:flutter_project_1/views/landing/landing_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 736),
        builder: () {
          return MultiProvider(
            providers: [
              Provider<AuthService>(
                create: (_) => AuthService(),
              ),
            ],
            child: MaterialApp(
              title: 'VAtraction',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: const LandingPage(),
            ),
          );
        });
  }
}
