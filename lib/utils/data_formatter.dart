import 'package:intl/intl.dart';

class DateFormatter {
  static String getVerboseDateTimeRepresentation(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();

    if (dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
      return 'Today';
    } else if (now.day - dateTime.day == 1 &&
        dateTime.month == now.month &&
        dateTime.year == now.year) {
      return 'Yesterday';
    }

    return '${DateFormat.yMd().format(dateTime)}';
  }
}
