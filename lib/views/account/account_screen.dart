import 'package:flutter/material.dart';
import 'package:flutter_project_1/services/auth_service.dart';
import 'package:flutter_project_1/view_models/locale_provider.dart';
import 'package:flutter_project_1/views/login/login_page.dart';
import 'package:flutter_project_1/widgets/rounded_linear_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  static const String nameRoute = '/account_screeen';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const AccountScreen(),
      settings: const RouteSettings(name: nameRoute),
    );
  }

  const AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text("HomeScreen"),
          RoundedLinearButton(
              text: "Log out",
              press: () async {
                await authService.signOut();
                Navigator.pushAndRemoveUntil(
                    context, LoginPage.route(), (route) => false);
              },
              textColor: Colors.black,
              startColor: Colors.grey,
              endColor: Colors.grey),
          Text(AppLocalizations.of(context).helloWorld),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<LocaleProvider>().changeLocale();
            },
            child: Text(AppLocalizations.of(context).changeLaguage),
          )
        ],
      ),
    );
  }
}
