import 'package:intl/intl.dart';

class DateFunctions{
  static String formatDateTime(String dateTimeStr) {
    final dateTime = DateTime.parse(dateTimeStr);

    final dayFormat = DateFormat('EEEE');
    final dateFormat = DateFormat('MMM d, y');
    final timeFormat = DateFormat('h:mm a');
    final formattedDay = dayFormat.format(dateTime);
    final formattedDate = dateFormat.format(dateTime);
    final formattedTime = timeFormat.format(dateTime);

    return '$formattedDay, $formattedDate . $formattedTime';
  }
}