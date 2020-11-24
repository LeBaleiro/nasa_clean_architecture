import 'package:intl/intl.dart';

class DateInputConverter {
  String format(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
