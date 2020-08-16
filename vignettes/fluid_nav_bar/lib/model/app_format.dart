import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_string.dart';

class AppFormat {
  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);
    return '${formatted}h';
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }

  static String dMMMyyyy(String yyyyMMdd) {
    final dateString = DateString.yyyyMMdd(yyyyMMdd);
    return DateFormat('d MMM yyyy', 'en').format(dateString.dateTime);
  }

  static Widget fixedText(
    String text, {
    EdgeInsets padding = const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    double width,
    double height,
    TextStyle style,
    TextAlign textAlign = TextAlign.start,
  }) {
    final richText = RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: text,
        style: style,
      ),
    );
    return Container(
      padding: padding,
      width: width,
      height: height,
      child: richText,
    );
  }
}
