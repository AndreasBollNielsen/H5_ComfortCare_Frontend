import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'APIService.dart';
import '/Model/DayTasks.dart';
import '/Model/Task.dart';

class ReposService {
  final ApiClient apiClient = ApiClient();

  // List<DayTasks> weekplan = [];
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

//fetch data from api and store it in secure storage
  Future<void> storeWeekplan() async {
    try {
      final data = await apiClient.GetWeekSchedule();
      if (data != null) {
        //store string as list
        final List<dynamic> weekplanJson = data as List<dynamic>;

        //convert json to model
        final List<DayTasks> weekplan = weekplanJson.map((dayTasksJson) {
          final dayTasksMap = dayTasksJson as Map<String, dynamic>;
          final day = dayTasksMap['day'] as String;
          final tasksJson = dayTasksMap['tasks'] as List<dynamic>;
          final tasks = tasksJson.map((taskJson) {
            final taskMap = taskJson as Map<String, dynamic>;
            return Task(
              startTime: DateTime.parse(taskMap['startTime']),
              endTime: DateTime.parse(taskMap['endTime']),
              address: taskMap['address'],
              citizenName: taskMap['citizenName'],
              taskDescription: taskMap['taskDescription'],
            );
          }).toList();

          return DayTasks(day: day, tasks: tasks);
        }).toList();

        // store weekplan in secure storage as JSON-string
        for (final dayTasks in weekplan) {
          final dayKey = 'day_${dayTasks.day}';
          final dayTasksJson = json.encode(dayTasks);
          await storage.write(key: dayKey, value: dayTasksJson);
        }
      } else {
        print('data is null');
      }
    } catch (e) {
      print('An error occurred while fetching weekplan: $e');
    }
  }

//get data from storage using a key
  Future<String?> GetStorageData(String key) async {
    final data = await storage.read(key: key);
    return data;
  }
}
