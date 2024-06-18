import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart'; // For date formatting
import '../Pages/HealthData.dart';

class HealthPage extends StatelessWidget {
  final List<HealthData> healthDataList;

  HealthPage({required this.healthDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildHealthChart(
                'Health Trends',
                _createHealthChartData(healthDataList),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildHealthList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthChart(
      String title, List<charts.Series<HealthData, String>> data) {
    return Card(
      elevation: 2.0,
      child: Container(
        height: 300.0,
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

  Widget _buildHealthList() {
    return Card(
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: healthDataList.map((data) {
            return ListTile(
              title: Text(
                  '${DateFormat('MM/dd/yyyy').format(data.date)}: Healthy Cows - ${data.healthyCows}, Sick Cows - ${data.sickCows}'),
            );
          }).toList(),
        ),
      ),
    );
  }

  static List<charts.Series<HealthData, String>> _createHealthChartData(
      List<HealthData> data) {
    return [
      charts.Series<HealthData, String>(
        id: 'Healthy Cows',
        domainFn: (HealthData health, _) =>
            DateFormat('MM/dd/yyyy').format(health.date),
        measureFn: (HealthData health, _) => health.healthyCows,
        data: data,
      ),
      charts.Series<HealthData, String>(
        id: 'Sick Cows',
        domainFn: (HealthData health, _) =>
            DateFormat('MM/dd/yyyy').format(health.date),
        measureFn: (HealthData health, _) => health.sickCows,
        data: data,
      ),
    ];
  }
}
