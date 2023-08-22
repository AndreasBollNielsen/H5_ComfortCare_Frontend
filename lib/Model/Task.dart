import 'Adress.dart';

class Task {
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String citizenName;
  final String fullAddress;
  final Address address;
  final double timeSpan;

  Task(
      {required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.citizenName,
      required this.fullAddress,
      required this.timeSpan,
      required this.address});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        title: json['titel'],
        description: json['description'],
        startDate: DateTime.parse(json['startDate']).toLocal(),
        citizenName: json['citizenName'],
        fullAddress: json['address'],
        timeSpan: json['timeSpan'].toDouble(),
        endDate: DateTime.parse(json['endDate']).toLocal(),
        address: Address.fromAddressString(json['address']));
  }

  Map<String, dynamic> toJson() {
    return {
      'titel': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'citizenName': citizenName,
      'address': fullAddress,
      'timeSpan': timeSpan
    };
  }
}
