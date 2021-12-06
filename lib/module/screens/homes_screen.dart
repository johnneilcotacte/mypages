import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/model/graph.dart';
import 'package:flutter_miniproject/module/home_screen_components/circular_graphs.dart';
import 'package:flutter_miniproject/module/home_screen_components/custom_drawer.dart';
import 'package:flutter_miniproject/module/home_screen_components/gradientbutton.dart';
import 'package:flutter_miniproject/module/home_screen_components/header.dart';
import 'package:flutter_miniproject/module/home_screen_components/meals_per_day.dart';
import 'package:flutter_miniproject/module/home_screen_components/weekly_calendar.dart';
import 'package:flutter_miniproject/module/home_screen_components/weekly_stats.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends HookWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    double _width = MediaQuery.of(context).size.width;
    List<Graph> _cal = [
      Graph(name: 'Cal', data: 75, color: Color.fromRGBO(235, 97, 143, 1)),
    ];
    List<Graph> _fats = [
      Graph(
        name: 'Fats',
        data: 60,
        color: Color.fromRGBO(145, 132, 202, 1),
      ),
    ];
    List<Graph> _carbs = [
      Graph(name: 'Carbs', data: 90, color: Color.fromRGBO(69, 187, 161, 1)),
    ];

    // List<Graph> _getChartData() {
    //   return [
    //     Graph(name: 'Cal', data: 75),
    //     Graph(name: 'Fats', data: 75),
    //     Graph(name: 'Carbs', data: 75),
    //   ];
    // }

    //  useEffect(
    //   () {
    //     _data = _getChartData();
    //     return;
    //   },
    //   [],
    // );
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: (!Responsive.isDesktop(context))
            ? Container(
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  onPressed: () {
                    // Scaffold.of(context).openDrawer();
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              )
            : null,
        actions: [
          Expanded(child: SizedBox()),
          Container(
            padding: EdgeInsets.only(right: 50),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage('assets/images/paksiw.jpg'),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Your Name',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: (!Responsive.isDesktop(context)) ? CustomDrawer() : null,
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) CustomDrawer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 56,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.all(30),
                    children: [
                      ////////////////////////////////////////////////////////////////
                      if (_width > 800)
                        Container(
                          height: 200,
                          child: Row(
                            children: [
                              Header(),
                              SizedBox(
                                width: 30,
                              ),
                              StatsCircularGraph(
                                  cal: _cal, fats: _fats, carbs: _carbs),
                            ],
                          ),
                        ),

                      if (_width <= 800) Header(),
                      if (_width <= 800)
                        SizedBox(
                          height: 30,
                        ),
                      if (_width <= 800)
                        StatsCircularGraph(
                            cal: _cal, fats: _fats, carbs: _carbs),
                      ////
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // ////////////////////////////////////////////////////////////////////////////
                      // Container(
                      //   height: 100,
                      //   child: Row(
                      //     children: [
                      //       Gradientbutton(),
                      //       WeeklyStats(),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // ////
                      // /////////////////////////////////////////////////////////////////////////////////////////////
                      // WeeklyCalendar(),
                      // //////////////////////////////////////////////////////////////////////////
                      // MealsPerDay(),
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
