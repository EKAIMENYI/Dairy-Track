import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../Pages/DailyData.dart'; // Adjust the import if necessary

class OverviewPage extends StatelessWidget {
  final List<DailyData> dailyDataList;

  OverviewPage({required this.dailyDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildSummaryCard(
                      'Milk Production', _calculateTotalMilkProduction()),
                  _buildSummaryCard(
                      'Healthy Cows', _calculateAverageHealthyCows()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildSummaryCard(
                      'Feed Consumption', '200kg/day'), // Example static data
                  _buildSummaryCard(
                      'Revenue', 'KSH 15,000'), // Example static data
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildChart('Production Chart',
                  _createProductionChartData(dailyDataList)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildChart(
                  'Health Chart', _createHealthChartData(dailyDataList)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: 150.0,
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 8.0),
            Text(value,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(
      String title, List<charts.Series<DailyData, String>> data) {
    return Card(
      elevation: 2.0,
      child: Container(
        height: 200.0,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 16.0)),
            Expanded(
              child: charts.BarChart(data, animate: true),
            ),
          ],
        ),
      ),
    );
  }

  static List<charts.Series<DailyData, String>> _createProductionChartData(
      List<DailyData> data) {
    return [
      charts.Series<DailyData, String>(
        id: 'Milk Production',
        domainFn: (DailyData overview, _) => overview.day,
        measureFn: (DailyData overview, _) => overview.milkProduction,
        data: data,
      )
    ];
  }

  static List<charts.Series<DailyData, String>> _createHealthChartData(
      List<DailyData> data) {
    return [
      charts.Series<DailyData, String>(
        id: 'Healthy Cows',
        domainFn: (DailyData overview, _) => overview.day,
        measureFn: (DailyData overview, _) => overview.healthyCows,
        data: data,
      )
    ];
  }

  String _calculateTotalMilkProduction() {
    int total = dailyDataList.fold(0, (sum, item) => sum + item.milkProduction);
    return '$total L';
  }

  String _calculateAverageHealthyCows() {
    if (dailyDataList.isEmpty) return '0%';
    double average =
        dailyDataList.fold(0, (sum, item) => sum + item.healthyCows) /
            dailyDataList.length;
    return '${average.toStringAsFixed(1)}%';
  }
}
