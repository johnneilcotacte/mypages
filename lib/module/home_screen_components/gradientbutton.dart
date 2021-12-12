import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/provider/gradientbutton_date_provider.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Gradientbutton extends HookWidget {
  Gradientbutton({
    Key? key,
  }) : super(key: key);
  // flex: 3,
  // fit: FlexFit.tight,
  @override
  Widget build(BuildContext context) {
    final selectedDate = useProvider(weekdateProvider);
    final dayofweek = DateFormat.E().format(selectedDate.date);
    final dayofmonth = DateFormat.d().format(selectedDate.date);
    final month = DateFormat.MMM().format(selectedDate.date);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (Responsive.isMobile(context)) ? width : 250,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade800, Colors.lightBlue.shade300],
        ),
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 5,
              //wrap this with flexible if inside a column or row
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Current Week',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$dayofweek, $month $dayofmonth',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 5,
            //wrap this with flexible if inside a column or row
            child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    print('clickedcALENDAR');
                    showCalendarDialog(context);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.calendarWeek,
                    size: 25,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

showCalendarDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(content: _DatePicker());
    },
  );
}

class _DatePicker extends HookWidget {
  const _DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendar = useProvider(weekdateProvider);
    final weekrange = calendar.getCurrentWeekRange();
    final datepickercontroller = DateRangePickerController();
    return Container(
      height: 300,
      width: 250,
      child: SfDateRangePicker(
        selectionMode: DateRangePickerSelectionMode.single,
        selectionShape: DateRangePickerSelectionShape.rectangle,
        initialSelectedDate: DateTime.now(),
        minDate: DateTime(
            weekrange[0].year, weekrange[0].month, weekrange[0].day, 0, 0, 0),
        maxDate: DateTime(
            weekrange[1].year, weekrange[1].month, weekrange[1].day, 0, 0, 0),
        showActionButtons: true,
        controller: datepickercontroller,
        onSubmit: (Object datepicked) {
          calendar.chooseDate(datepickercontroller.selectedDate!);
          Navigator.pop(context);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

showInvalidDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog _alert = AlertDialog(
    title: Text('Error'),
    content: Text('No Date Selected!'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _alert;
    },
  );
}
