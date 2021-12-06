import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Material(
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
                  'November 29, 2021 - December 3, 2021',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
