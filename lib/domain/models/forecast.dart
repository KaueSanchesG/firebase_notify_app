class Forecast {
  final DateTime date;
  final double riverDischarge;
  final double trustability;

  Forecast({
    required this.date,
    required this.riverDischarge,
    required this.trustability,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.parse(json['date']),
      riverDischarge: json['riverDischarge'],
      trustability: json['trustability'],
    );
  }
}
