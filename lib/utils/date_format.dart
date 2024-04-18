import 'package:intl/intl.dart';

String formatTime(String dateTime) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime date = inputFormat.parse(dateTime);

  DateFormat outputFormat = DateFormat("h:mm a");
  return outputFormat.format(date);
}
