import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../Model/DayTasks.dart';
import '../Model/Employee.dart';
import '/Model/Task.dart';

class ApiClient {
  // final String ip = '10.0.2.2';
  // final String localIP = '192.168.0.180';
  // final String port = '5270';
  final String baseUrl = 'http://192.168.0.180:5270/api/Test/LoginTestEmployee';

  ApiClient();

  Future<Map<String, dynamic>> login(Employee employee) async {
    final url = Uri.parse(baseUrl);
    final data = jsonEncode(employee.toJson());
    // print('data to send: $data');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: data);
      if (response.statusCode == 200) {
        var result = await response.body;
        // final jsonData = json.decode(result);
        final parsed = jsonDecode(result) as Map<String, dynamic>;
        // print("repsonse $jsonData");
        return parsed;
      } else {
        print("repsonse ${response.statusCode}");
        //return response.statusCode.toString();
        final Map<String, dynamic> nullObject = {};
        return nullObject;
      }
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }

//get week schedule
  Future<String> GetWeekSchedule() async {
    final url = Uri.parse(baseUrl);
    print("calling week schedult");
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
