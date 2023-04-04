import 'package:intl/intl.dart';

class HelperFunctions {
  static String formatDateToDate(String unformatted) {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(unformatted));
  }

  static String formatDateToTime(String unformatted) {
    return DateFormat('hh:mm a').format(DateTime.parse(unformatted));
  }

  static bool isOpen(DateTime open, DateTime close) {
    DateTime now = DateTime.now();
    if (now.hour <= close.hour && now.hour >= open.hour) {
      if (now.minute <= close.minute && now.minute >= open.minute) {
        return true;
      }
      return false;
    }
    return false;
  }
}
