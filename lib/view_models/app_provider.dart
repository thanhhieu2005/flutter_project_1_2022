import 'package:flutter/cupertino.dart';

//example
class AppProvider extends ChangeNotifier {
  Locale _locale = const Locale("en");

  Locale get locale => _locale;

  void toggleLocale() {
    if (_locale.languageCode == "vi") {
      _locale = const Locale("en");
    } else {
      _locale = const Locale("vi");
    }
    notifyListeners();
  }
}
