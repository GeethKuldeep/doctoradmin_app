class SensorData {
  final double val;
  final int time;

  SensorData(this.time, this.val);
}

// final data = [
//     new SalesData(0, 1500000),
//     new SalesData(1, 1735000),
//     new SalesData(2, 1678000),
//     new SalesData(3, 1890000),
//     new SalesData(4, 1907000),
//     new SalesData(5, 2300000),
//     new SalesData(6, 2360000),
//     new SalesData(7, 1980000),
//     new SalesData(8, 2654000),
//     new SalesData(9, 2789070),
//     new SalesData(10, 3020000),
//     new SalesData(11, 3245900),
//     new SalesData(12, 4098500),
//     new SalesData(13, 4500000),
//     new SalesData(14, 4456500),
//     new SalesData(15, 3900500),
//     new SalesData(16, 5123400),
//     new SalesData(17, 5589000),
//     new SalesData(18, 5940000),
//     new SalesData(19, 6367000),
//  ];

// _getSeriesData() {
//     List<Series<SalesData, int>> series = [
//       Series(
//         id: "Sales",
//         data: data,
//         domainFn: (SalesData series, _) => series.year,
//         measureFn: (SalesData series, _) => series.sales,
//         colorFn: (SalesData series, _) => MaterialPalette.blue.shadeDefault
//       )
//     ];
//     return series;
// }
