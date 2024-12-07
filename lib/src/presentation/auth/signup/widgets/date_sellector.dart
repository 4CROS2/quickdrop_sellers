import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class DateSellector extends StatefulWidget {
  const DateSellector({super.key});

  @override
  State<DateSellector> createState() => _DateSellectorState();
}

class _DateSellectorState extends State<DateSellector> {
  String date = 'Fecha de nacimiento';

  void _setDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        date = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Constants.mainColor,
      borderRadius: Constants.mainBorderRadius,
      child: InkWell(
        onTap: () {
          _setDate(context);
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: Constants.authInputContent,
            child: Text(
              date,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
