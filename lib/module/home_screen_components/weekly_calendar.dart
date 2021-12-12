import 'package:flutter/material.dart';

class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // decoration:
      //     BoxDecoration(border: Border.all(width: 0.3), color: Colors.white),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(-10.0, 10.0),
              blurRadius: 20.0,
              spreadRadius: 4.0),
        ],
      ),
      padding: EdgeInsets.only(left: 50, right: 50),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Date(
              date: '29',
              day: 'Monday',
            ),
            _Date(
              date: '30',
              day: 'Tuesday',
            ),
            _Date(
              date: '01',
              day: 'Wednesday',
            ),
            _Date(
              date: '02',
              day: 'Thursday',
            ),
            _Date(
              date: '03',
              day: 'Friday',
            ),
            _Date(
              date: '04',
              day: 'Saturday',
            ),
            _Date(
              date: '05',
              day: 'Sunday',
            ),
          ],
        ),
      ),
    );
  }
}

class _Date extends StatelessWidget {
  final String date;
  final String day;
  const _Date({
    Key? key,
    required this.date,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(date),
        SizedBox(
          height: 15,
        ),
        Text(
          day,
        )
      ],
    );
  }
}
