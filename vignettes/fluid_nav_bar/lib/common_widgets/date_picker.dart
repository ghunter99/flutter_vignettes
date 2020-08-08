import 'package:flutter/material.dart';

import '../model/format.dart';
import 'input_dropdown.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key key,
    @required this.labelText,
    @required this.selectedDate,
//    this.selectedTime,
    this.onSelectedDate,
//    this.onSelectedTime,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
//  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> onSelectedDate;
//  final ValueChanged<TimeOfDay> onSelectedTime;
  final DateTime firstDate;
  final DateTime lastDate;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(DateTime.now().year - 1),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.headline4;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: InputDropdown(
            labelText: labelText,
            valueText: AppFormat.date(selectedDate),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
      ],
    );
  }
}
