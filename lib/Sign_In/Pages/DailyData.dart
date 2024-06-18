class DailyData {
  final String day; // Day of the week
  final DateTime date; // Date of the data entry
  int milkProduction; // Amount of milk produced
  int healthyCows; // Number of healthy cows
  int? sickCows; // Number of sick cows (optional)
  double? amount; // Example financial data (optional)
  String? description; // Example financial data description (optional)

  DailyData({
    required this.day,
    required this.date,
    required this.milkProduction,
    required this.healthyCows,
    this.sickCows,
    this.amount,
    this.description,
  });
}
