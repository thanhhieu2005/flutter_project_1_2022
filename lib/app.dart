import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_1/routes/app_route.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/view_models/locale_provider.dart';
import 'package:flutter_project_1/view_models/login_provider.dart';
import 'package:flutter_project_1/view_models/post_provider.dart';
import 'package:flutter_project_1/view_models/sign_up_provider.dart';
import 'package:flutter_project_1/views/landing/landing_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'l10n/support_locale.dart';

class VAtractionApp extends StatelessWidget {
  const VAtractionApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 736),
        builder: () {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthService>(
                  create: (_) => AuthService(),
                ),
                ChangeNotifierProvider<PostProvider>(
                  create: (_) => PostProvider(),
                ),
                ChangeNotifierProvider<SignUpProvider>(
                  create: (_) => SignUpProvider(),
                ),
                ChangeNotifierProvider<LoginProvider>(
                  create: (_) => LoginProvider(),
                ),
              ],
              child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                onGenerateRoute: AppRoutes.onGenerateRoute,
                // ignore: prefer_const_literals_to_create_immutables
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: context.watch<LocaleProvider>().locale,
                // ignore: prefer_const_literals_to_create_immutables
                supportedLocales: L10n.support,
                debugShowCheckedModeBanner: false,
                home: const LandingPage(),
              ));
        });
  }
}
