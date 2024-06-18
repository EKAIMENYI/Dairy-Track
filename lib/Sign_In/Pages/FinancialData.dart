//import 'package:flutter/material.dart'; // Ensure you import the necessary packages

class FinancialData {
  DateTime transactionDate;
  double amount;
  DateTime date;
  int revenue;
  int expenses;
  int profit;
  String description;

  FinancialData({
    required this.date,
    required this.amount,
    required this.description,
    required this.transactionDate,
    required this.revenue,
    required this.expenses,
    required this.profit,
  });
}
