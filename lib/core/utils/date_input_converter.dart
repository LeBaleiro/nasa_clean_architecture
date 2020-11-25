class DateInputConverter {
  String format(DateTime dateTime) {
    var dateSplitted = dateTime.toString().split(' ');

    return dateSplitted.first;
  }
}
