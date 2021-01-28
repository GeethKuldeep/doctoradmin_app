
import 'package:charts_flutter/flutter.dart';
import 'package:doctoradmin_app/app/GraphData.dart';

class DataToGraph {
  List<Series<SensorData, int>> series;
  manageData(int s) {
    List<SensorData> data=[];
    List val = [
      10007.0,
      9979.0,
      9935.0,
      9922.0,
      9924.0,
      9956.0,
      9991.0,
      9992.0,
      9986.0,
      9943.0,
      9914.0,
      9914.0,
      9925.0,
      9970.0,
      9992.0,
      9999.0,
      9963.0,
      9923.0,
      9903.0,
      9902.0,
      9926.0,
      9953.0,
      9953.0,
      9938.0,
      9904.0,
      9877.0,
      9888.0,
      9921.0,
      10021.0,
      10133.0,
      10275.0,
      10470.0,
      10646.0,
      11882.0,
      12165.0,
      12938.0,
      14424.0,
      14707.0,
      14902.0,
      15150.0,
      15357.0,
      16448.0,
      16870.0,
      17040.0,
      17383.0,
      17621.0,
      17608.0,
      17625.0,
      17639.0,
      17653.0,
      17648.0,
      17613.0,
      17604.0,
      17575.0,
      17579.0,
      17599.0,
      17702.0,
      17756.0,
      17782.0,
      17963.0,
      17964.0,
      17970.0,
      17998.0,
      18016.0,
      18045.0,
      18071.0,
      18107.0,
      18131.0,
      18143.0,
      18127.0,
      18102.0,
      18062.0,
      18046.0,
      18038.0,
      18027.0,
      18026.0,
      18055.0,
      18084.0,
      18103.0,
      18121.0,
      18128.0,
      18152.0,
      18182.0,
      18195.0,
      18169.0,
      18169.0,
      18117.0,
      17938.0,
      17711.0,
      17590.0,
      17410.0,
      16513.0,
      16371.0,
      15297.0,
      14429.0,
      13543.0,
      13314.0,
      12012.0,
      11570.0,
      11150.0,
      10913.0,
      10713.0,
      10442.0,
      10306.0,
      10228.0,
      10154.0,
      10113.0,
      10089.0,
      10069.0,
      10061.0,
      10081.0,
      10091.0,
      10081.0,
      10074.0,
      10047.0,
      10004.0,
      9971.0,
      9960.0,
      9957.0,
      9978.0,
      10004.0,
      10015.0,
      10013.0,
      9999.0,
      9957.0,
      9923.0,
      9912.0,
      9915.0,
      9942.0,
      9971.0,
      9972.0,
      9964.0,
      9923.0,
      9889.0,
      9882.0,
      9886.0,
      9924.0,
      9948.0,
      9946.0,
      9931.0,
      9885.0,
      9864.0,
      9861.0,
      9877.0,
      9914.0,
      9928.0,
      9924.0,
      9895.0,
      9857.0,
      9841.0,
      9841.0,
      9873.0,
      9907.0,
      9908.0,
      9900.0,
      9858.0,
      9830.0,
      9825.0,
      9836.0,
      9873.0,
      9893.0,
      9897.0,
      9872.0,
      9833.0,
      9814.0,
      9820.0,
      9844.0,
      9894.0,
      9909.0,
      9901.0,
      9865.0,
      9821.0,
      9813.0,
      9819.0,
      9862.0,
      9888.0,
      9891.0,
      9882.0,
      9879.0,
      9921.0,
      9990.0,
      10148.0,
      10261.0,
      10337.0,
      10374.0,
      10481.0,
      10525.0,
      10588.0,
      10662.0,
      10739.0,
      10808.0,
      10958.0,
      11332.0,
      11524.0,
      11643.0,
      11857.0,
      11930.0,
      12123.0,
      12552.0,
      12942.0,
      14165.0,
      14553.0,
      14741.0,
      14738.0,
      14725.0,
      14832.0,
      15226.0,
      15492.0,
      15588.0,
      15629.0,
      15721.0,
      16102.0,
      15926.0,
      15613.0,
      15473.0,
      16671.0,
      16868.0,
      16931.0,
      17085.0,
      16782.0,
      16346.0,
      16230.0,
      16231.0,
      17801.0,
      17406.0,
      17493.0,
      17962.0,
      17981.0,
      18344.0,
      18514.0,
      18673.0,
      18688.0,
      18636.0,
      18654.0,
      18613.0,
      18652.0,
      18506.0,
      18873.0,
      18495.0,
      18355.0,
      18341.0,
      18226.0,
      18562.0,
      18330.0,
      18103.0,
      17773.0,
      17963.0,
      18145.0,
      17924.0,
      17875.0,
      17864.0,
      17869.0,
      17898.0,
      17925.0,
      17950.0,
      17965.0,
      17973.0,
      18000.0,
      17944.0,
      17917.0,
      17882.0,
      17837.0,
      17793.0,
      17776.0,
      17762.0,
      17752.0,
      17735.0,
      17727.0,
      17739.0,
      17776.0,
      17732.0,
      17326.0,
      15901.0,
      14121.0,
      13228.0,
      12337.0,
      12012.0,
      11825.0,
      11629.0,
      11483.0,
      11330.0,
      11054.0,
      10878.0,
      10792.0,
      10621.0,
      10488.0,
      10425.0,
      10385.0,
      10378.0,
      10383.0,
      10378.0,
      10359.0,
      10335.0,
      10285.0,
      10235.0,
      10208.0,
      10195.0,
      10199.0,
      10224.0,
      10237.0,
      10226.0,
      10214.0,
      10175.0,
      10132.0,
      10115.0,
      10109.0,
      10118.0,
      10149.0,
      10165.0,
      10166.0,
      10153.0,
      10108.0,
      10068.0,
      10059.0,
      10067.0,
      10089.0,
      10122.0,
      10116.0,
      10112.0,
      10077.0,
      10030.0,
      10009.0,
      9997.0,
      10019.0,
      10045.0,
      10047.0,
      10043.0,
      10009.0,
      9972.0,
      9956.0,
      9955.0,
      9984.0,
      10019.0,
      10018.0,
      10012.0,
      9976.0,
      9944.0,
      9935.0,
      9940.0,
      9976.0,
      9999.0,
      9997.0,
      9978.0,
      9935.0,
      9918.0,
      9917.0
    ];
    List time = [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      46,
      47,
      48,
      49,
      50,
      51,
      52,
      53,
      54,
      55,
      56,
      57,
      58,
      59,
      60,
      61,
      62,
      63,
      64,
      65,
      66,
      67,
      68,
      69,
      70,
      71,
      72,
      73,
      74,
      75,
      76,
      77,
      78,
      79,
      80,
      81,
      82,
      83,
      84,
      85,
      86,
      87,
      88,
      89,
      90,
      91,
      92,
      93,
      94,
      95,
      96,
      97,
      98,
      99,
      100,
      101,
      102,
      103,
      104,
      105,
      106,
      107,
      108,
      109,
      110,
      111,
      112,
      113,
      114,
      115,
      116,
      117,
      118,
      119,
      120,
      121,
      122,
      123,
      124,
      125,
      126,
      127,
      128,
      129,
      130,
      131,
      132,
      133,
      134,
      135,
      136,
      137,
      138,
      139,
      140,
      141,
      142,
      143,
      144,
      145,
      146,
      147,
      148,
      149,
      150,
      151,
      152,
      153,
      154,
      155,
      156,
      157,
      158,
      159,
      160,
      161,
      162,
      163,
      164,
      165,
      166,
      167,
      168,
      169,
      170,
      171,
      172,
      173,
      174,
      175,
      176,
      177,
      178,
      179,
      180,
      181,
      182,
      183,
      184,
      185,
      186,
      187,
      188,
      189,
      190,
      191,
      192,
      193,
      194,
      195,
      196,
      197,
      198,
      199,
      200,
      201,
      202,
      203,
      204,
      205,
      206,
      207,
      208,
      209,
      210,
      211,
      212,
      213,
      214,
      215,
      216,
      217,
      218,
      219,
      220,
      221,
      222,
      223,
      224,
      225,
      226,
      227,
      228,
      229,
      230,
      231,
      232,
      233,
      234,
      235,
      236,
      237,
      238,
      239,
      240,
      241,
      242
    ];
    if (s == 1) {
      for (int i = 0; i < 11; i++) {
        data.add(new SensorData(time[i], val[i]));
      }
    } else if (s == 2) {
      for (int i = 0; i < 121; i++) {
        data.add(new SensorData(time[i], val[i]));
      }
    } else if (s == 3) {
      for (int i = 0; i < 242; i++) {
        data.add(new SensorData(time[i], val[i]));
      }
    } else {
      for (int i = 0; i < val.length; i++) {
        data.add(new SensorData(i, val[i]));
      }
    }
    return data;
  }

  getSeriesData(List<SensorData> data) {
    series = [
      Series(
          id: "Sensor Data",
          data: data,
          domainFn: (SensorData series, _) => series.time,
          measureFn: (SensorData series, _) => series.val,
          colorFn: (SensorData series, _) => MaterialPalette.deepOrange.shadeDefault)
    ];
    return series;
  }
}
