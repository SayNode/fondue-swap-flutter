import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PriceRangeSelectorController extends GetxController {
  RxBool canSelectPRiceRange = true.obs;
  late SfRangeValues rangeValues;
  @override
  void onInit() {
    rangeValues = const SfRangeValues(4, 8);
    super.onInit();
  }

  Widget buildChart() {
    return SizedBox(
      height: 250,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(isVisible: false),
        primaryYAxis: const NumericAxis(isVisible: false, maximum: 4),
        series: <SplineAreaSeries<Data, double>>[
          SplineAreaSeries<Data, double>(
            dataSource: getChartData(),
            xValueMapper: (Data sales, int index) => sales.x,
            yValueMapper: (Data sales, int index) => sales.y,
          ),
        ],
      ),
    );
  }

  List<Data> getChartData() {
    return <Data>[
      Data(x: 2, y: 2.2),
      Data(x: 3, y: 3.4),
      Data(x: 4, y: 2.8),
      Data(x: 5, y: 1.6),
      Data(x: 6, y: 2.3),
      Data(x: 7, y: 2.5),
      Data(x: 8, y: 2.9),
      Data(x: 9, y: 3.8),
      Data(x: 10, y: 3.7),
    ];
  }
}

class Data {
  Data({required this.x, required this.y});
  final double x;
  final double y;
}
