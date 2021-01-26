import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";

class Graph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(

        gridData: FlGridData(
          getDrawingHorizontalLine: (value){
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          drawVerticalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(5.8, 2.5),
              FlSpot(6, 4),
              FlSpot(6.5, 3),
              FlSpot(7, 4),

            ],
            isCurved:true,
          )
        ]
      ),


    );

  }
}
