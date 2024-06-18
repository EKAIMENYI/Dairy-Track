import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import DateFormat from intl package
import 'package:charts_flutter/flutter.dart' as charts;
import '../Pages/FinancialData.dart';

class FinancialsPage extends StatelessWidget {
  final List<FinancialData> financialDataList;

  FinancialsPage({required this.financialDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildFinancialChart('Financial Trends',
                  _createFinancialChartData(financialDataList)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildFinancialList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialChart(
      String title, List<charts.Series<FinancialData, String>> data) {
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

  Widget _buildFinancialList() {
    return Card(
      elevation: 2.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: financialDataList.map((data) {
            return ListTile(
              title: Text(
                  '${DateFormat.yMMMd().format(data.date)}: Revenue - ${data.revenue} KSH, Expenses - ${data.expenses} KSH, Profit - ${data.profit} KSH'),
            );
          }).toList(),
        ),
      ),
    );
  }

  static List<charts.Series<FinancialData, String>> _createFinancialChartData(
      List<FinancialData> data) {
    return [
      charts.Series<FinancialData, String>(
        id: 'Revenue',
        domainFn: (FinancialData finance, _) =>
            DateFormat.yMMMd().format(finance.date),
        measureFn: (FinancialData finance, _) => finance.revenue,
        data: data,
      ),
      charts.Series<FinancialData, String>(
        id: 'Expenses',
        domainFn: (FinancialData finance, _) =>
            DateFormat.yMMMd().format(finance.date),
        measureFn: (FinancialData finance, _) => finance.expenses,
        data: data,
      ),
      charts.Series<FinancialData, String>(
        id: 'Profit',
        domainFn: (FinancialData finance, _) =>
            DateFormat.yMMMd().format(finance.date),
        measureFn: (FinancialData finance, _) => finance.profit,
        data: data,
      ),
    ];
  }
}
