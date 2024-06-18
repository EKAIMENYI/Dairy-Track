import 'package:flutter/material.dart';
import 'DataInputPage.dart';
import 'OverviewPage.dart';
import 'ProductionPage.dart';
import 'HealthPage.dart';
import 'FinancialsPage.dart';
import 'SettingsPage.dart'; // Import SettingsPage.dart
import '../Pages/DailyData.dart';
import '../Pages/HealthData.dart';
import '../Pages/FinancialData.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  List<DailyData> _dailyDataList = []; // List to store daily data
  List<HealthData> _healthDataList = []; // List to store health data
  List<FinancialData> _financialDataList = []; // List to store financial data

  void _addDailyData(DailyData data) {
    setState(() {
      _dailyDataList.add(data);
    });
  }

  void _addHealthData(HealthData data) {
    setState(() {
      _healthDataList.add(data);
    });
  }

  void _addFinancialData(FinancialData data) {
    setState(() {
      _financialDataList.add(data);
    });
  }

  void _onSubmit(dynamic data) {
    if (data is DailyData) {
      if (isHealthData(data)) {
        _addHealthData(HealthData(
          date: data.date,
          healthyCows: data.healthyCows,
          sickCows: data.sickCows ?? 0,
        ));
      } else if (isFinancialData(data)) {
        _addFinancialData(FinancialData(
          date: data.date,
          amount: data.amount ?? 0.0,
          description: data.description ?? '',
          transactionDate: data.date,
          revenue: 0,
          expenses: 0,
          profit: 0,
        ));
      } else {
        _addDailyData(data);
      }
    }
  }

  bool isHealthData(DailyData data) {
    return data.healthyCows != null && data.sickCows != null;
  }

  bool isFinancialData(DailyData data) {
    return data.amount != null && data.description != null;
  }

  List<Widget> _pages() {
    return [
      OverviewPage(dailyDataList: _dailyDataList),
      ProductionPage(dailyDataList: _dailyDataList),
      HealthPage(healthDataList: _healthDataList),
      FinancialsPage(financialDataList: _financialDataList),
      DataInputPage(
          title: 'Enter Data', onSubmit: _onSubmit), // Include DataInputPage
      SettingsPage(), // Include SettingsPage
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DairyTrack Dashboard'),
      ),
      body: _selectedIndex >= 0 && _selectedIndex < _pages().length
          ? _pages()[_selectedIndex]
          : Container(), // Handle invalid index gracefully
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Production',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Financials',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input), // Icon for Data Input tab
            label: 'Data Input', // Label for Data Input tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: _selectedIndex == 4 // Index of Data Input tab
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataInputPage(
                      title: 'Enter Data',
                      onSubmit: _onSubmit,
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
