import 'package:flutter/cupertino.dart';
import 'package:flutter_project_1/l10n/support_locale.dart';

//example
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale? get locale => _locale;
  void changeLocale() {
    _locale =
        _locale.languageCode == 'vi' ? const Locale('en') : const Locale('vi');
    notifyListeners();
  }
}
