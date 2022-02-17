import 'package:flutter/material.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphs extends StatefulWidget {
  Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
 
  @override
  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, 'Ressources Relationnelles'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
        children: [
          Column(
            children: [
              Text('Utilisateurs connectés par jour.'),
               SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              BarSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]),
            ],
          )
        ],
      ),)
      );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
 
  final String x;
  final double y;
}
