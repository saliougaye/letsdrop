bool isToday(DateTime datetime) {

  final date = DateTime(datetime.year, datetime.month, datetime.day);
  final now = DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day);

  return date.difference(now).inDays == 0;
}

DateTime onlyDate(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

int dayDifference(DateTime first, DateTime second) {
  return onlyDate(first).difference(onlyDate(second)).inDays;
}