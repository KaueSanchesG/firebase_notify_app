class HistoryData {
  final double max;
  final double min;
  final double avg;

  HistoryData({required this.max, required this.min, required this.avg});

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(max: json['max'], min: json['min'], avg: json['avg']);
  }
}
