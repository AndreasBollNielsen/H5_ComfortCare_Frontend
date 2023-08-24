import 'Adress.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

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

  //factory to convert json to task
  factory Task.fromJson(Map<String, dynamic> json) {
    // parse dates and try setting the correct timezone
    final est = tz.getLocation('Europe/Copenhagen');
    final dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    final startDate = dateFormat.parse(json['startDate'], true);
    final endDate = dateFormat.parse(json['endDate'], true);

    //temp variables used for setting timezone
    DateTime estStartDate;
    DateTime estEndDate;

    //check if timezone is UTC
    if (startDate.isUtc) {
      // set the new timezone to CEST
      estStartDate = tz.TZDateTime.from(startDate, est);
      estEndDate = tz.TZDateTime.from(endDate, est);

      //DEBUG
      print(
          'before: ${startDate.timeZoneOffset} after: ${estStartDate.timeZoneOffset} date: ${startDate}');
    } else {
      //set the variables to current timezone if timezone is CEST
      estStartDate = startDate;
      estEndDate = endDate;
    }

    return Task(
      title: json['titel'],
      description: json['description'],
      startDate: estStartDate,
      citizenName: json['citizenName'],
      fullAddress: json['address'],
      timeSpan: json['timeSpan'].toDouble(),
      endDate: estEndDate,
      address: Address.fromAddressString(json['address']),
    );
  }

  //factory to convert task into jason format
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
