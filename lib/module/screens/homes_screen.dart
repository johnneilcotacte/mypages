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
import 'package:flutter_miniproject/provider/const_provider.dart';
import 'package:flutter_miniproject/provider/current_user_provider.dart';
import 'package:flutter_miniproject/provider/meal_provider.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends HookWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = useProvider(currentUserProvider);
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

    useEffect(
      () {
        print('homepage');
      },
      [],
    );

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
                  //backgroundImage: NetworkImage(_user.user!.avatarURL!),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  _user.user!.username!,
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
          (Responsive.isDesktop(context))
              ? CustomDrawer()
              : Container(
                  width: 1,
                ),
          Expanded(
            child: Container(
              width: (Responsive.isMobile(context)) ? _width : null,
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
                      shrinkWrap: true,
                      padding: EdgeInsets.all(30),
                      children: [
                        ////////////////////////////////////////////////////////////////
                        if (Responsive.isDesktop(context))
                          Container(
                            width: _width,
                            height: 200,
                            child: Row(
                              children: [
                                Header(),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Center(
                                    child: StatsCircularGraph(
                                        cal: _cal, fats: _fats, carbs: _carbs),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // if(Responsive.is)
                        //                             Column(
                        //                                   children: [
                        //                                     Header(),
                        //                                     SizedBox(
                        //                                       height: 20,
                        //                                     ),
                        //                                     Expanded(
                        //                                       child: Center(
                        //                                         child: StatsCircularGraph(
                        //                                             cal: _cal,
                        //                                             fats: _fats,
                        //                                             carbs: _carbs),
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 ),

                        if (!Responsive.isDesktop(context))
                          Container(
                              width: _width, height: 200, child: Header()),
                        if (!Responsive.isDesktop(context))
                          SizedBox(
                            height: 30,
                          ),
                        if (Responsive.isTablet(context))
                          Container(
                            width: _width,
                            height: 170,
                            child: StatsCircularGraph(
                                cal: _cal, fats: _fats, carbs: _carbs),
                          ),

                        if (Responsive.isMobile(context))
                          Container(
                            height: 170,
                            width: 150,
                            child: CircularGraph(
                              type: _cal,
                              text: 'Cals',
                            ),
                          ),
                        if (Responsive.isMobile(context))
                          SizedBox(
                            height: 20,
                          ),
                        if (Responsive.isMobile(context))
                          Container(
                            height: 170,
                            width: 150,
                            child: CircularGraph(
                              type: _fats,
                              text: 'Fats',
                            ),
                          ),
                        if (Responsive.isMobile(context))
                          SizedBox(
                            height: 20,
                          ),
                        if (Responsive.isMobile(context))
                          Container(
                            height: 170,
                            width: 150,
                            child: CircularGraph(
                              type: _carbs,
                              text: 'Carbs',
                            ),
                          ),
                        SizedBox(
                          height: 30,
                        ),

                        if (!Responsive.isMobile(context))
                          Container(
                            width: _width,
                            height: 100,
                            child: Row(
                              children: [
                                Gradientbutton(),
                                if (!Responsive.isMobile(context))
                                  Expanded(child: WeeklyStats())
                              ],
                            ),
                          ),
                        if (Responsive.isMobile(context)) Gradientbutton(),
                        if (Responsive.isMobile(context)) WeeklyStats(),
                        SizedBox(
                          height: 30,
                        ),

                        WeeklyCalendar(),

                        MealsPerDay(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
