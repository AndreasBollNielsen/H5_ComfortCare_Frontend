import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Model/Employee.dart';
import 'APIService.dart';
import '/Model/DayTasks.dart';
import '/Model/Task.dart';
import 'package:intl/intl.dart';

class ReposService {
  final ApiClient _apiService = ApiClient();

  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

//fetch data from api and store it in secure storage
  Future<void> storeWeekplan(
      Map<String, dynamic> data, String jwt, String userName) async {
    try {
      //check if data is null
      if (data != null) {
        //convert json to model
        Map<String, dynamic> jsonData = data;
        final _name = jsonData['name'] as String;

        //casting json array into dynamic list
        final assignmentsJson = jsonData['assignments'] as List<dynamic>;

        //convert dynamic list into task list
        final assignments =
            assignmentsJson.map((taskJson) => Task.fromJson(taskJson)).toList();

        //group tasks to same day
        assignments.sort((a, b) => a.startDate.day.compareTo(b.startDate.day));

        for (var i = 0; i < assignments.length; i++) {
          print(
              'startDate: ${assignments[i].startDate} day: ${_getDayName(assignments[i].startDate)}');
        }

        //create daytasks list
        List<DayTasks> weekTasks = [];

        //get earliest date
        DateTime earliestDate = DateTime.now();

        //adds task to corresponding day of the week
        for (var day in _getWeekNames(earliestDate)) {
          List<Task> tasks = [];
          for (var element in assignments) {
            var currentDay = DateTime(element.startDate.year,
                element.startDate.month, element.startDate.day);

            //if days match add task to current day
            if (currentDay.month == day.month && currentDay.day == day.day) {
              tasks.add(element);
            }
          }

          weekTasks
              .add(DayTasks(day: _getDayName(day), tasks: tasks, name: _name));
        }

        //sorts tasks start time from lowest to highest numerically
        try {
          for (var weektask in weekTasks) {
            weektask.tasks.sort((a, b) => a.startDate.compareTo(b.startDate));
          }
        } catch (e) {
          print('sort numerically: $e');
        }

        //clear securestorage
        await storage.deleteAll();

        // store weekplan in secure storage as JSON-string
        try {
          final weekTasksJson = json
              .encode(weekTasks.map((dayTasks) => dayTasks.toJson()).toList());
          //  final currentUser = json.encode(weekTasks[0].name);
          final currentUser = userName;
          await storage.write(key: 'weekTasks', value: weekTasksJson);
          await storage.write(key: 'user', value: currentUser);
          await storage.write(key: 'jwt', value: jwt);
        } catch (e) {
          print("failed to write to secureStorage: $e");
        }
      } else {
        print('data is null');
      }
    } catch (e) {
      print('An error occurred while fetching weekplan: $e');
    }
  }

  //method that retrieves the week schedule model
  Future<List<DayTasks>?> GetDaySchedule() async {
    var readSchedule = await _getStorageData();

    if (readSchedule != null) {
      return readSchedule;
    } else {
      print("No data found.");
      return null;
    }
  }

  //gets week schedule data from securestorage
  Future<List<DayTasks>?> _getStorageData() async {
    final data = await storage.read(key: 'weekTasks');
    final jsonData = json.decode(data!);
    if (jsonData != null) {
      final dayTasksList = jsonData
          .map<DayTasks>((dayTasksJson) => DayTasks.fromJson(dayTasksJson))
          .toList();
      return dayTasksList;
    }
    return null;
  }

  //gets user credentials from securestorage or jwt token
  Future<bool> GetUserInitials(Employee user) async {
    //maybe future use of jwt
    final data = await storage.read(key: 'jwt');

    //fetch username from securestorage
    final userData = await storage.read(key: 'user');

    //check if user exists & compare to current login attempt
    if (userData != null) {
      if (userData == user.name) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  // Helper method to get the day name
  String _getDayName(DateTime date) {
    final weekdayFormat = DateFormat('EEEE', 'da_DK');
    final dayName = weekdayFormat.format(date.toLocal());

    return _capitalizeFirstLetter(dayName);
  }

  //Helper method to capitalize first letter
  String _capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  //method to get list of dates of the week
  List<DateTime> _getWeekNames(DateTime currentDate) {
    DateTime endDate = currentDate.add(Duration(days: 7));

    final daysToGenerate = endDate.difference(currentDate).inDays;
    final List<DateTime> weekDates = List.generate(
        daysToGenerate, (i) => currentDate.add(Duration(days: i)));

    return weekDates;
  }
}
