import 'package:intl/intl.dart';

class HelperFunctions {
  static String formatDateToDate(String unformatted) {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(unformatted));
  }

  static String formatDateToTime(String unformatted) {
    return DateFormat('hh:mm a').format(DateTime.parse(unformatted));
  }
}
