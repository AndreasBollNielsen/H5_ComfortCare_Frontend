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

  Task(
      {required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.citizenName,
      required this.fullAddress,
      required this.address});

  //factory to convert json to task
  factory Task.fromJson(Map<String, dynamic> json) {
    //convert full address into proper format
    String address = json['address'];
    List<String> addressParts = address.split(',');
    addressParts = addressParts.map((part) => part.trim()).toList();
    addressParts.removeWhere((string) => string.isEmpty);
    if (addressParts.length < 3) {
      address = '${addressParts[0]},${addressParts[1]}';
    } else {
      address = '${addressParts[0]},${addressParts[1]},${addressParts[2]}';
    }

    return Task(
      title: json['titel'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      citizenName: json['citizenName'],
      fullAddress: address,
      endDate: DateTime.parse(json['endDate']),
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
      'address': fullAddress
    };
  }

  //helper method to return dateTime in hours & minutes
  String GetDateHourFormatted(DateTime date) {
    final dateFormat = DateFormat('HH:mm');
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  //helper method to return dateTime in weekDay & date
  String ConvertToDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE d MMMM', 'da_DK');
    return formatter.format(date);
  }
}
