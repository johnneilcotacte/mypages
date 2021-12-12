import 'package:flutter/cupertino.dart';
import 'package:flutter_miniproject/api/auth.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/provider/meal_api_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final weekdateProvider = ChangeNotifierProvider<WeeklyDate>((ref) {
  return WeeklyDate();
});

class WeeklyDate extends ChangeNotifier {
  //String _date = DateFormat.yMMMMd('en_US').format(DateTime.now());
  DateTime _date = DateTime.now();
  List<DateTime> getCurrentWeekRange() {
    var d = DateTime.now();

    var weekDay = d.weekday;

    var firstDayOfWeek = d.subtract(Duration(days: weekDay - 1));

    var lastDayOfWeek = d.add(Duration(days: DateTime.daysPerWeek - weekDay));

    // String firstdayofweek = DateFormat.yMMMMd('en_US').format(firstDayOfWeek);
    // String lastdayofweek = DateFormat.yMMMMd('en_US').format(lastDayOfWeek);
    return [firstDayOfWeek, lastDayOfWeek];
  }

  void chooseDate(DateTime time) {
    //  _date = DateFormat.yMMMMd('en_US').format(time);
    _date = time;
    notifyListeners();
  }

  DateTime get date => _date;
}
