import 'package:flutter/material.dart';
import 'package:flutter_miniproject/responsive.dart';

class WeeklyStats extends StatelessWidget {
  const WeeklyStats({
    Key? key,
  }) : super(key: key);
  // fit: FlexFit.tight,
  //     flex: 5,
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: (Responsive.isMobile(context)) ? width : null,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Goals'),
              SizedBox(
                height: 15,
              ),
              Text(
                'This Week',
                style: TextStyle(
                  color: Colors.cyan,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Calories'),
              SizedBox(
                height: 15,
              ),
              Text(
                '14k',
                style: TextStyle(
                  color: Colors.green,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Carbs'),
              SizedBox(
                height: 15,
              ),
              Text(
                '1540',
                style: TextStyle(
                  color: Colors.purple,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fats'),
              SizedBox(
                height: 15,
              ),
              Text(
                '600',
                style: TextStyle(
                  color: Colors.pink,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Protien'),
              SizedBox(
                height: 15,
              ),
              Text(
                '1250',
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
