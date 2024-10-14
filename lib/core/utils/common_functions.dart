import 'package:intl/intl.dart';

class CommonFunctions {

  formatDate(DateTime selectedDay, String format) {
    final DateFormat outputFormat = DateFormat(format);
    return outputFormat.format(selectedDay);
  }
}