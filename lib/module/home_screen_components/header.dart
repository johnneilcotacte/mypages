import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class Header extends HookWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String firstdayofweek = '';
    String lastdayofweek = '';
    //https://stackoverflow.com/questions/58287278/how-to-get-start-of-or-end-of-week-in-dart/58287666
    _getCurrentWeek() {
      var d = DateTime.now();
      var weekDay = d.weekday;
      var firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));
      var lastDayOfWeek = d.add(Duration(days: DateTime.daysPerWeek - weekDay));
      firstdayofweek = DateFormat.yMMMMd('en_US').format(firstDayOfWeek);
      lastdayofweek = DateFormat.yMMMMd('en_US').format(lastDayOfWeek);
    }

    useEffect(
      () {
        _getCurrentWeek();
      },
      [],
    );
    return Material(
      child: Container(
        padding: EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Plan your Week',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Meal Planner',
              style: TextStyle(color: Colors.black, fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            FittedBox(
              child: Text(
                '$firstdayofweek - $lastdayofweek',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
