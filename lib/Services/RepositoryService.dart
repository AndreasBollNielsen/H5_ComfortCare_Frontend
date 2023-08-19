import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  Future<void> storeWeekplan(Map<String, dynamic> data) async {
    try {
      //check if data is null
      if (data != null) {
        //convert json to model
        // Map<String, dynamic> jsonData = jsonDecode(data);
        Map<String, dynamic> jsonData = data;
        final _name = jsonData['name'] as String;

        //DBUG json
        // for (var jsonObj in jsonData['assignments']) {
        //   print('json dat: ${jsonObj['startDate']}');

        //   var task = Task.fromJson(jsonObj);
        //   print('   model: ${task.startDate}');
        // }
        for (int index = 0; index < jsonData['assignments'].length; index++) {
          var jsonObj = jsonData['assignments'][index];
          //print('index: $index jData $index: ${jsonObj['startDate']}');
          // print('jData ${jsonObj['startDate']}');
          DateTime myDateTime = DateTime.parse(jsonObj[
              'startDate']); // Din DateTime, erstat med den ønskede dato
          String formattedDate = DateFormat.MMMd().format(
              myDateTime); // "MMM" for forkortet månedsnavn og "d" for dagen
          print('jData $formattedDate'); // Udskriver f.eks. "Aug 12"

          var task = Task.fromJson(jsonObj);
          var formattedTask = DateFormat.MMMd().format(task.startDate);
          //  print('index: $index model $index: ${task.startDate}');
          // print('model ${formattedTask}');

          // var jsonDate = DateTime.parse(jsonObj['startDate']);
          // if (jsonDate != task.startDate) {
          // }
        }

        //her sker der noget mystisk noget?
        // final assignmentsJson = jsonData['assignments'] as List<dynamic>;
        final assignmentsJson = jsonData['assignments'] as List<dynamic>;

        // //DEBUG model
        // for (int index = 0; index < assignmentsJson.length; index++) {
        //   var element = assignmentsJson[index];
        //   var task = Task.fromJson(element);
        //   print('model $index: ${task.startDate}');
        // }

        final assignments =
            assignmentsJson.map((taskJson) => Task.fromJson(taskJson)).toList();
        var test = 0;
        //group tasks to same day
        //ukorrekt liste af tasks
        assignments.sort((a, b) => a.startDate.compareTo(b.startDate));

        int mondays = 0;
        int tuesdays = 0;
        int wednessdays = 0;
        int thursdays = 0;
        int fridays = 0;
        int saturdays = 0;
        int sundays = 0;

        for (var element in assignments) {
          if (_getDayName(element.startDate.day) == 'Mandag') {
            mondays += 1;
          } else if (_getDayName(element.startDate.day) == 'Tirsdag') {
            tuesdays += 1;
          } else if (_getDayName(element.startDate.day) == 'Onsdag') {
            wednessdays += 1;
          } else if (_getDayName(element.startDate.day) == 'Torsdag') {
            thursdays += 1;
          } else if (_getDayName(element.startDate.day) == 'Fredag') {
            fridays += 1;
          } else if (_getDayName(element.startDate.day) == 'Lørdag') {
            saturdays += 1;
          } else if (_getDayName(element.startDate.day) == 'Søndag') {
            sundays += 1;
          }
        }

        print(
            'mondays: $mondays\n tuesdays: $tuesdays\n wednessdays: $wednessdays\n thursdays: $thursdays\n fridays: $fridays\n saturdays: $saturdays\n sundays: $sundays\n');

        //create daytasks list
        List<DayTasks> weekTasks = [];

        for (var day in _getWeekNames()) {
          List<Task> tasks = [];
          for (var element in assignments) {
            var currentDay = _getDayName(element.startDate.weekday);

            if (currentDay == day) {
              tasks.add(element);
              print(
                  'currentDay: ${currentDay} nextDay: ${day} tasks: ${tasks.length}');
            }
          }
          weekTasks.add(DayTasks(day: day, tasks: tasks, name: _name));
        }

        // //temporary lists
        // String currentDay = _getDayName(assignments[0].startDate.weekday);
        // List<Task> currentDayTasks = [];
        // print(currentDay);
        // //generate week schedule
        // for (Task task in assignments) {
        //   DateTime startDate = DateTime(
        //       task.startDate.year, task.startDate.month, task.startDate.day);

        //   //add new daytasks if current day changed
        //   if (currentDay == null ||
        //       _getDayName(startDate.weekday) != currentDay) {
        //     if (currentDay != null) {
        //       weekTasks.add(DayTasks(
        //           name: _name, day: currentDay, tasks: currentDayTasks));
        //     }
        //     // print(currentDay);
        //     //add current day if null
        //     currentDay = _getDayName(startDate.weekday);
        //     currentDayTasks = [task];
        //   } else {
        //     currentDayTasks.add(task);
        //   }
        //   //print('number of tasks ${currentDayTasks.length} day: ${currentDay}');
        // }

        // //add tasks for the week
        // if (currentDay != null) {
        //   weekTasks.add(
        //       DayTasks(name: _name, day: currentDay, tasks: currentDayTasks));
        // }

        for (var element in weekTasks) {
          print('day: ${element.day} tasks: ${element.tasks.length}');
        }

        //  sortere tidspunkterne ud fra morgen til aften
        // for (var daytask in weekTasks) {
        //   daytask.tasks.sort((task1, task2) {
        //     final startTime1 =
        //         task1.startDate.hour * 60 + task1.startDate.minute;
        //     final startTime2 =
        //         task2.startDate.hour * 60 + task2.startDate.minute;
        //     return startTime1.compareTo(startTime2);
        //   });
        // }
        // print('number of tasks ${weekTasks[0].tasks.length}');
        // store weekplan in secure storage as JSON-string
        try {
          final weekTasksJson = json
              .encode(weekTasks.map((dayTasks) => dayTasks.toJson()).toList());
          await storage.write(key: 'weekTasks', value: weekTasksJson);
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

  Future<List<DayTasks>?> GetDaySchedule() async {
    var readSchedule = await _getStorageData();

    if (readSchedule != null) {
      return readSchedule;
    } else {
      print("No data found.");
    }
  }

  Future<List<DayTasks>?> _getStorageData() async {
    final data = await storage.read(key: 'weekTasks');
    final jsonData = json.decode(data!);
    if (jsonData != null) {
      final dayTasksList = jsonData
          .map<DayTasks>((dayTasksJson) => DayTasks.fromJson(dayTasksJson))
          .toList();
      return dayTasksList;
    }
  }

  // Helper method to get the day name
  String _getDayName(int index) {
    final now = DateTime.now();
    final dayIndex = (now.weekday + index) % 7;
    return [
      'Mandag',
      'Tirsdag',
      'Onsdag',
      'Torsdag',
      'Fredag',
      'Lørdag',
      'Søndag'
    ][dayIndex];
  }

// Helper method to get a list of week
  List<String> _getWeekNames() {
    return [
      'Mandag',
      'Tirsdag',
      'Onsdag',
      'Torsdag',
      'Fredag',
      'Lørdag',
      'Søndag'
    ];
  }
}
