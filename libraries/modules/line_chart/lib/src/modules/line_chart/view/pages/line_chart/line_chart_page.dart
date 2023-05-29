import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartPage extends StatefulWidget {
  const LineChartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  ZoomPanBehavior zoomPanBehavior = ZoomPanBehavior(
    enableDoubleTapZooming: true,
    enablePinching: true,
    enablePanning: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Line Chart'),
      ),
      body: Center(
        child: SizedBox(
          width: Sizes.width(context) * 0.9, // Adjust the width as needed
          height: Sizes.height(context) * 0.6, // Adjust the height as needed
          child: SfCartesianChart(
            zoomPanBehavior: zoomPanBehavior,
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              LineSeries<SalesData, DateTime>(
                dataSource: getData(),
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<SalesData> getData() {
    return <SalesData>[
      SalesData(DateTime(2021), 35),
      SalesData(DateTime(2021, 2), 28),
      SalesData(DateTime(2021, 3), 34),
      SalesData(DateTime(2021, 4), 32),
      SalesData(DateTime(2021, 5), 40),
      SalesData(DateTime(2021, 6), 45),
      SalesData(DateTime(2021, 7), 48),
      SalesData(DateTime(2021, 8), 50),
      SalesData(DateTime(2021, 9), 55),
      SalesData(DateTime(2021, 10), 58),
      SalesData(DateTime(2021, 11), 60),
      SalesData(DateTime(2021, 12), 64),
    ];
  }
}

class SalesData {
  final DateTime year;
  final double sales;

  SalesData(this.year, this.sales);
}
