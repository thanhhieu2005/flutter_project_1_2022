import 'package:intl/intl.dart';

class DateConfig {
  static String fortmattedDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static int daysBetweenNow(DateTime from) {
    from = DateTime(from.year, from.month, from.day);
    var now = DateTime.now();
    DateTime to = DateTime(now.year, now.month, now.day);

    return (to.difference(from).inHours / 24).round();
  }
}
