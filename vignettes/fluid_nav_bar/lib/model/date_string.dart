import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Date as a string with format yyyymmdd

class DateString {
  DateString(DateTime date)
      : assert(date != null, 'DateSring can not be null') {
    if (date != null) {
      _dateTime = date;
    }
  }

  DateString.yyyyMMdd(String yyyyMMdd)
      : assert(yyyyMMdd != null, 'yyyyMMdd must not be null'),
        assert(yyyyMMdd.length == 8, 'yyyyMMdd must be 8 characters long') {
    _yyyyMMdd = yyyyMMdd;
  }

  DateString.today([DateTime now]) {
    // Construct [DateTime] with current date and time in local time zone.
    _dateTime = now ?? DateTime.now();
  }

  DateString.tomorrow([DateTime now]) {
    // Construct [DateTime] with current date and time in local time zone.
    now ??= DateTime.now();
    final DateString today = DateString.today(now);

    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    _dateTime = today.dateTime.add(const Duration(days: 1, hours: 12));
  }

  DateString.yesterday([DateTime now]) {
    // Construct [DateTime] with current date and time in local time zone.
    now ??= DateTime.now();
    final DateString today = DateString.today(now);

    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    _dateTime = today.dateTime.add(const Duration(days: -1, hours: 12));
  }

  DateString.withOffset(
    DateString dateString, {
    @required int days,
  }) : assert(dateString != null, 'DateString can not be null') {
    final DateTime date = dateString.dateTime; // [DateTime] with time removed
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    _dateTime = date.add(Duration(days: days, hours: 12));
  }

  String _yyyyMMdd;

  String get yyyyMMdd => _yyyyMMdd;

  DateTime get dateTime => _dateTime;

  DateTime get _dateTime {
    final str = '${_yyyyMMdd.substring(0, 4)}-' // year
        '${_yyyyMMdd.substring(4, 6)}-' // month
        '${_yyyyMMdd.substring(6)}'; // day
    return DateFormat('yyyy-MM-dd').parse(str);
  }

  set _dateTime(DateTime dateTime) =>
      _yyyyMMdd = DateFormat('yyyyMMdd').format(dateTime);

  DateTime get dateTimeUtc {
    String str = _yyyyMMdd;
    str = '${str.substring(0, 4)}-${str.substring(4, 6)}-${str.substring(6)}';
    return DateFormat('yyyy-MM-dd').parse(str, true); // UTC date without time
  }

  String get iSO8601Date {
    final String str = _yyyyMMdd;
    return '${str.substring(0, 4)}-${str.substring(4, 6)}-${str.substring(6)}';
  }

  bool isSameDay(String other) {
    return yyyyMMdd == other;
  }

  bool isAfter(String other) {
    return yyyyMMdd.compareTo(other) > 0;
  }

  bool isBefore(String other) {
    return yyyyMMdd.compareTo(other) < 0;
  }

  DateString get firstDayOfWeek {
    DateTime date = dateTime; // [DateTime] with time removed
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    date = date.add(const Duration(hours: 12));

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    final decreaseNum = date.weekday % 7;
    date = date.subtract(Duration(days: decreaseNum));
    return DateString(date);
  }

  DateString get lastDayOfWeek {
    DateTime date = dateTime; // [DateTime] with time removed
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    date = date.add(const Duration(hours: 12));

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    final increaseNum = date.weekday % 7;
    date = date.add(Duration(days: 7 - increaseNum));
    return DateString(date);
  }

  int dayDifference(DateString date) {
    /// Remove daylight saving differences by converting dates to UTC
    final DateTime date1 = dateTimeUtc; // [DateTime] with time removed
    final DateTime date2 = date.dateTimeUtc; // [DateTime] with time removed
    final duration = date1.difference(date2);
    return duration.inDays;
  }

  /// Returns number of years, as an integer, between date and now
  int get ageInYears {
    final DateTime currentDate = DateTime.now();
    final DateTime birthDate = _dateTime;
    int age = currentDate.year - birthDate.year;
    final int month1 = currentDate.month;
    final int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final int day1 = currentDate.day;
      final int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age < 0 ? 0 : age;
  }

  /// Returns a [DateTime] for each day in the given range.
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(
      DateString start, DateString end) sync* {
    var element = start;
    while (element.isBefore(end.yyyyMMdd)) {
      DateTime date = element.dateTime; // [DateTime] with time removed
      yield date;

      /// Handle Daylight Savings by setting hour to 12:00 Noon
      /// rather than the default of Midnight
      date = date.add(const Duration(days: 1, hours: 12));
      element = DateString(date);
    }
  }

  static const List<String> weekdays = ['SU', 'M', 'TU', 'W', 'TH', 'F', 'SA'];
}
