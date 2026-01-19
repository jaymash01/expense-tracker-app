import 'dart:math' as math;

import 'package:intl/intl.dart';

String numberFormat(dynamic number) {
  if (number.runtimeType == String) {
    number = double.parse(number);
  }

  return NumberFormat('#,###,###.##').format(number);
}

double round(num value, int decimalPlaces) {
  num mod = math.pow(10.0, decimalPlaces);
  return ((value * mod).round().toDouble() / mod);
}

String niceDate(String date) {
  DateTime dateTime = DateTime.parse(date).toLocal();
  DateFormat formatter = DateFormat('MMM dd, yyyy');
  return formatter.format(dateTime);
}

String formatDate(dynamic date, String format) {
  if (date.runtimeType == String) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}

DateTime parseDate(String date) {
  return DateTime.parse(date).toLocal();
}
