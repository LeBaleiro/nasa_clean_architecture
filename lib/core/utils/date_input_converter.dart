class DateInputConverter {
  String format(DateTime dateTime) {
    print("dada ${dateTime}");
    var dateSplitted = dateTime.toString().split(' ');

    return dateSplitted.first;
  }
}
