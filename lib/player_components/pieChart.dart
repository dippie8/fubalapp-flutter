import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'indicator.dart';

class MyPieChart extends StatelessWidget {

  final int _wins;
  final int _total;

  int _touchedIndex;


  MyPieChart(this._wins, this._total);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: PieChart(
        dataMap: {
          "Vittorie": _wins.toDouble(),
          "Sconfitte": _total.toDouble() - _wins.toDouble()
        },
        animationDuration: Duration(milliseconds: 500),
        chartLegendSpacing: 50,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: [Colors.tealAccent.shade400, Colors.pinkAccent],
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 40,
        centerText: _total == 0 ? "" : (_wins/_total*100).floor().toString() + "%",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: false,
          showChartValues: true,
          decimalPlaces: 0,
          chartValueStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900),
          showChartValuesInPercentage: false,
          showChartValuesOutside: true,
        ),
      ),
    );

  }



}
