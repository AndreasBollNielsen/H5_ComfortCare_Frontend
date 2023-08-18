class Task {
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String citizenName;
  final String address;
  final double timeSpan;

  Task({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.citizenName,
    required this.address,
    required this.timeSpan,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['titel'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      citizenName: json['citizenName'],
      address: json['address'],
      timeSpan: json['timeSpan'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titel': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'citizenName': citizenName,
      'address': address,
      'timeSpan': timeSpan
    };
  }
}
