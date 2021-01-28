import 'package:charts_flutter/flutter.dart';
import "package:flutter/material.dart";

import 'DataManipulation.dart';

class Graph3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 325,
      child: LineChart(
        DataToGraph().getSeriesData(
            DataToGraph().manageData(3)),
        animate: true,
      ),
    );

  }
}
