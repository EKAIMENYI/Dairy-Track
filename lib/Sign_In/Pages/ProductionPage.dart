import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../Pages/DailyData.dart';

class ProductionPage extends StatelessWidget {
  final List<DailyData> dailyDataList;

  ProductionPage({required this.dailyDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Production Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProductionChart('Milk Production Trends',
                  _createProductionChartData(dailyDataList)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProductionList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductionChart(
      String title, List<charts.Series<DailyData, String>> data) {
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

  Widget _buildProductionList() {
    return Card(
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: dailyDataList.map((data) {
            return ListTile(
              title: Text('${data.day}: ${data.milkProduction} L'),
            );
          }).toList(),
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
}
