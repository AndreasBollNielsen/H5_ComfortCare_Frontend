import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter_comfortcare/Model/ResponseBody.dart';
import 'package:http/http.dart' as http;

import '../Model/DayTasks.dart';
import '../Model/Employee.dart';
import '/Model/Task.dart';

class ApiClient {
  //home ip
  final String baseUrl = 'http://192.168.0.180:5270/api/Test/LoginTestEmployee';

  //schoolIp
  //final String baseUrl = 'http://10.108.138.33:5270/api/Test/LoginTestEmployee';

  ApiClient();

  Future<APIResponse> login(Employee employee) async {
    final url = Uri.parse(baseUrl);
    final data = jsonEncode(employee.toJson());

    try {
      final response = await http
          .post(url, headers: {'Content-Type': 'application/json'}, body: data)
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        var result = await response.body;
        final parsed = jsonDecode(result) as Map<String, dynamic>;
        return APIResponse(
            body: parsed, statusCode: response.statusCode, message: '');
      } else {
        // print("Response ${response.statusCode}");
        final Map<String, dynamic> nullObject = {};
        return APIResponse(
            body: nullObject,
            statusCode: response.statusCode,
            message: 'Error: ${response.statusCode} Not Found');
      }
    } on TimeoutException catch (e) {
      //print("TimeoutException: $e");
      final Map<String, dynamic> timeoutError = {};
      return APIResponse(
          body: timeoutError,
          statusCode: 504,
          message:
              'Connection timed out. Please try again later.'); // Gateway Timeout
    } catch (e) {
      print(e);
      final Map<String, dynamic> errorResponse = {'error': e.toString()};
      return APIResponse(
          body: errorResponse,
          statusCode: 500,
          message: 'oops something went wrong'); // A generic error code
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
