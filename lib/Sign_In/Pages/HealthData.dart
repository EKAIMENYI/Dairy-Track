//import 'package:flutter/material.dart'; // Import necessary packages

class HealthData {
  final DateTime date; // Date of health data entry
  final int healthyCows; // Number of healthy cows
  final int sickCows; // Number of sick cows

  HealthData({
    required this.date,
    required this.healthyCows,
    required this.sickCows,
  });
}
