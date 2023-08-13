import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/DayTasks.dart';
import '/Model/Task.dart';

class ApiClient {
  final String baseUrl = 'https://catfact.ninja/fact';

  ApiClient();

  Future<String> login(String endpoint) async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

//get week schedule
  Future<String> GetWeekSchedule() async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {

        //using dummy data until api is available
        final dummyWeekScheduleJson = generateDummyWeekScheduleJson();
        return dummyWeekScheduleJson;
      } else {
        var status = response.statusCode.toString();
        return status;
      }
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

//generating dummy data
  String generateDummyWeekScheduleJson() {
    final weekplan = [
      {
        'day': 'Monday',
        'tasks': [
          {
            'startTime': DateTime.now().toIso8601String(),
            'endTime': DateTime.now().add(Duration(hours: 1)).toIso8601String(),
            'address': '123 Main St',
            'citizenName': 'John Doe',
            'taskDescription': 'Task description',
          },
        ],
      },
      // ... Add more days and tasks here
    ];

    return json.encode(weekplan);
  }
}
