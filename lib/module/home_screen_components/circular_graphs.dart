import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/model/graph.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsCircularGraph extends HookWidget {
  StatsCircularGraph({
    Key? key,
    required List<Graph> cal,
    required List<Graph> fats,
    required List<Graph> carbs,
  })  : _cal = cal,
        _fats = fats,
        _carbs = carbs,
        super(key: key);

  final List<Graph> _cal;
  final List<Graph> _fats;
  final List<Graph> _carbs;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final _choiceindex = useState(0);
    final List<List<Graph>> _choices = [_cal, _fats, _carbs];
    final List<String> _choiceslabel = ['Cals', 'Fats', 'Carbs'];

    _checkCurrentCardIndex(int direction) {
      // 1 = left
      // 2 = right
      print('clicked');
      if (direction == 1) {
        if (_choiceindex.value > 0) {
          _choiceindex.value--;
        }
      }
      if (direction == 2) {
        if (_choiceindex.value < 2) {
          print(_choiceindex.value);
          _choiceindex.value++;
        }
      }
    }

    return Container(
        decoration: BoxDecoration(color: Colors.white),
        // height: (Responsive.isMobile(context)) ? 850 : null,
        // width: (Responsive.isMobile(context)) ? 280 : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //https://help.syncfusion.com/flutter/circular-charts/chart-types/radial-bar-chart
            Expanded(
              child: CircularGraph(
                type: _cal,
                text: 'Cals',
              ),
            ),
            Expanded(
              child: CircularGraph(
                type: _fats,
                text: 'Fats',
              ),
            ),
            Expanded(
              child: CircularGraph(
                type: _carbs,
                text: 'Carbs',
              ),
            ),
          ],
        ));

    // } else if (Responsive.isMobile(context))
  }
}

class CircularGraph extends HookWidget {
  CircularGraph({Key? key, required this.type, required this.text})
      : super(key: key);

  final List<Graph> type;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SfCircularChart(
        title: ChartTitle(
          text: text,
          alignment: ChartAlignment.center,
          textStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
        series: <CircularSeries>[
          RadialBarSeries<Graph, String>(
            cornerStyle: CornerStyle.bothCurve,
            dataSource: type,
            xValueMapper: (Graph type, _) => type.name,
            yValueMapper: (Graph type, _) => type.data,
            maximumValue: 100,
            trackOpacity: .4,
            innerRadius: '70%',
            radius: '70%',
            pointColorMapper: (Graph type, _) => type.color,
            dataLabelSettings: DataLabelSettings(
                isVisible: true, labelPosition: ChartDataLabelPosition.outside),
          )
        ],
      ),
    );
  }
}


// Container(
//       decoration: BoxDecoration(color: Colors.white),
//       height: (Responsive.isMobile(context)) ? 850 : null,
//       width: (Responsive.isMobile(context)) ? 280 : null,
//       child: (!Responsive.isMobile(context))
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 //https://help.syncfusion.com/flutter/circular-charts/chart-types/radial-bar-chart
//                 CircularGraph(
//                   type: _cal,
//                   text: 'Cals',
//                 ),
//                 CircularGraph(
//                   type: _fats,
//                   text: 'Fats',
//                 ),
//                 CircularGraph(
//                   type: _carbs,
//                   text: 'Carbs',
//                 ),
//               ],
//             )
//           : Container(
//               // height: 300,
//               // width: 250,
//               // decoration: BoxDecoration(color: Colors.white),
//               child: Column(
//                 children: [
//                   // Row(
//                   //   crossAxisAlignment: CrossAxisAlignment.center,
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     // IconButton(
//                   //     //   enableFeedback: false,
//                   //     //   onPressed: _checkCurrentCardIndex(1),
//                   //     //   icon: FaIcon(
//                   //     //     FontAwesomeIcons.chevronLeft,
//                   //     //     size: 12,
//                   //     //     color: (_choiceindex.value == 0)
//                   //     //         ? Colors.grey
//                   //     //         : Colors.blue,
//                   //     //   ),
//                   //     // ),
//                   //     // SizedBox.fromSize(
//                   //     //   size: Size(56, 56), // button width and height
//                   //     //   child: ClipOval(
//                   //     //     child: Material(
//                   //     //       color: Colors.orange, // button color
//                   //     //       child: InkWell(
//                   //     //         splashColor: Colors.green, // splash color
//                   //     //         onTap:
//                   //     //             _checkCurrentCardIndex(2), // button pressed
//                   //     //         child: Column(
//                   //     //           mainAxisAlignment: MainAxisAlignment.center,
//                   //     //           children: <Widget>[
//                   //     //             Icon(Icons.call), // icon
//                   //     //             Text("Call"), // text
//                   //     //           ],
//                   //     //         ),
//                   //     //       ),
//                   //     //     ),
//                   //     //   ),
//                   //     // ),
//                   //     // IconButton(
//                   //     //   onPressed: _checkCurrentCardIndex(2),
//                   //     //   icon: FaIcon(
//                   //     //     FontAwesomeIcons.chevronRight,
//                   //     //     size: 12,
//                   //     //     color: (_choiceindex.value == 2)
//                   //     //         ? Colors.grey
//                   //     //         : Colors.blue,
//                   //     //   ),
//                   //     // )
//                   //   ],
//                   // ),

//                   // CircularGraph(
//                   //   type: _choices[_choiceindex.value],
//                   //   text: _choiceslabel[_choiceindex.value],
//                   // ),
//                   //                  SizedBox(
//                   //   height: 20,
//                   // ),
//                   // CircularGraph(
//                   //   type: _choices[_choiceindex.value],
//                   //   text: _choiceslabel[_choiceindex.value],
//                   // ),

//                 ],
//               ),
//             ),
//     )