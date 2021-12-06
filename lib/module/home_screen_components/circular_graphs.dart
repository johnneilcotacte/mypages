import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/model/graph.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsCircularGraph extends HookWidget {
  const StatsCircularGraph({
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
      if (direction == 1) {
        if (_choiceindex.value > 0) {
          _choiceindex.value--;
        }
      }
      if (direction == 2) {
        if (_choiceindex.value < 2) {
          _choiceindex.value++;
        }
      }
    }

    return Flexible(
      fit: FlexFit.tight,
      flex: (_width > 800) ? 5 : 1,
      //wrap this with flexible if inside a column or row
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: (!Responsive.isMobile(context))
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //https://help.syncfusion.com/flutter/circular-charts/chart-types/radial-bar-chart
                  _CircularGraph(
                    type: _cal,
                    text: 'Cals',
                  ),
                  _CircularGraph(
                    type: _fats,
                    text: 'Fats',
                  ),
                  _CircularGraph(
                    type: _carbs,
                    text: 'Carbs',
                  ),
                ],
              )
            : Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _checkCurrentCardIndex(1),
                          icon: FaIcon(
                            FontAwesomeIcons.chevronLeft,
                            size: 12,
                            color: (_choiceindex.value == 0)
                                ? Colors.grey
                                : Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: _checkCurrentCardIndex(2),
                          icon: FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: 12,
                            color: (_choiceindex.value == 2)
                                ? Colors.grey
                                : Colors.blue,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _CircularGraph(
                      type: _choices[_choiceindex.value],
                      text: _choiceslabel[_choiceindex.value],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _CircularGraph extends StatelessWidget {
  _CircularGraph({Key? key, required this.type, required this.text})
      : super(key: key);

  final List<Graph> type;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside),
            )
          ],
        ),
      ),
    );
  }
}
