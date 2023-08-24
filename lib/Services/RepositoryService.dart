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
        Map<String, dynamic> jsonData = data;
        final _name = jsonData['name'] as String;

        //DBUG json-------------------------------------------------------------
        // for (int index = 0; index < jsonData['assignments'].length; index++) {
        //   var jsonObj = jsonData['assignments'][index];
        //   //print('index: $index jData $index: ${jsonObj['startDate']}');
        //   // print('jData ${jsonObj['startDate']}');
        //   String raw = jsonObj['startDate'];
        //   DateTime myDateTime = DateTime.parse(raw);
        //   String formattedDate = DateFormat.MMMd().format(myDateTime.toLocal());
        //   //  print('jData $formattedDate'); // Udskriver f.eks. "Aug 12"

        //   var task = Task.fromJson(jsonObj);
        //   var formattedTask = DateFormat.MMMd().format(task.startDate);
        //   //  print('index: $index model $index: ${task.startDate}');
        //   print(
        //       'raw ${jsonObj['startDate']} jData $formattedDate model ${formattedTask}');

        //   // var jsonDate = DateTime.parse(jsonObj['startDate']);
        //   // if (jsonDate != task.startDate) {
        //   // }
        // }

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
        assignments
            .sort((a, b) => a.startDate.weekday.compareTo(b.startDate.weekday));

        //DEBUG-----------------------------------------------------------------
        // int mondays = 0;
        // int tuesdays = 0;
        // int wednessdays = 0;
        // int thursdays = 0;
        // int fridays = 0;
        // int saturdays = 0;
        // int sundays = 0;

        // for (var element in assignments) {
        //   if (_getDayName(element.startDate) == 'Mandag') {
        //     mondays += 1;
        //   } else if (_getDayName(element.startDate) == 'Tirsdag') {
        //     tuesdays += 1;
        //   } else if (_getDayName(element.startDate) == 'Onsdag') {
        //     wednessdays += 1;
        //   } else if (_getDayName(element.startDate) == 'Torsdag') {
        //     thursdays += 1;
        //   } else if (_getDayName(element.startDate) == 'Fredag') {
        //     fridays += 1;
        //   } else if (_getDayName(element.startDate) == 'Lørdag') {
        //     saturdays += 1;
        //   } else if (_getDayName(element.startDate) == 'Søndag') {
        //     sundays += 1;
        //   }
        // }

        // print(
        //     'mondays: $mondays\n tuesdays: $tuesdays\n wednessdays: $wednessdays\n thursdays: $thursdays\n fridays: $fridays\n saturdays: $saturdays\n sundays: $sundays\n');
//------------------------------------------------------------------------------
        //create daytasks list
        List<DayTasks> weekTasks = [];

        //adds task to corresponding day of the week
        for (var day in _getWeekNames()) {
          List<Task> tasks = [];
          for (var element in assignments) {
            var currentDay = _getDayName(element.startDate);

            if (currentDay == day) {
              tasks.add(element);
              print(
                  'currentDay: ${currentDay} nextDay: ${day} tasks: ${tasks.length} date: ${element.startDate}');
            }
          }
          weekTasks.add(DayTasks(day: day, tasks: tasks, name: _name));
        }

        //DEBUG
        for (var element in weekTasks) {
          print('day: ${element.day} tasks: ${element.tasks.length}');
        }

        weekTasks.sort(
            (a, b) => a.tasks[0].startDate.compareTo(b.tasks[0].startDate));

        for (var weektask in weekTasks) {
          weektask.tasks.sort((a, b) => a.startDate.compareTo(b.startDate));
        }
        //  sort time periods from morning to night
        // for (var daytask in weekTasks) {
        //   daytask.tasks.sort((task1, task2) {
        //     // var startTime1 = task1.startDate.hour * 60 + task1.startDate.minute;
        //     // var startTime2 = task2.startDate.hour * 60 + task2.startDate.minute;

        //     // // Hvis starttiden er efter midnat (dvs. tidlig morgen), tilføj 24 timer for korrekt sammenligning.
        //     // if (startTime1 < 7 * 60) startTime1 += 24 * 60;
        //     // if (startTime2 < 7 * 60) startTime2 += 24 * 60;

        //     // return startTime1.compareTo(startTime2);

        //   });
        // }
        //  print('number of tasks ${weekTasks[0].tasks.length}');

        //DEBUG clear securestorage
        await storage.deleteAll();

        // store weekplan in secure storage as JSON-string
        try {
          final weekTasksJson = json
              .encode(weekTasks.map((dayTasks) => dayTasks.toJson()).toList());
          final currentUser = json.encode(weekTasks[0].name);
          await storage.write(key: 'weekTasks', value: weekTasksJson);
          await storage.write(key: 'user', value: currentUser);
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

  Future<bool> GetUserInitials() async {
    final data = await storage.read(key: 'user');

    if (data != null) {
      final jsonData = json.decode(data!);
      print(jsonData);
      return true;
    } else {
      return false;
    }
  }

  // Helper method to get the day name
  String _getDayName(DateTime date) {
    // final now = DateTime.now();
    // final dayIndex = (now.weekday + index) % 7;
    // return [
    //   'Mandag',
    //   'Tirsdag',
    //   'Onsdag',
    //   'Torsdag',
    //   'Fredag',
    //   'Lørdag',
    //   'Søndag'
    // ][dayIndex];
    final weekdayFormat =
        DateFormat('EEEE', 'da_DK'); // 'da_DK' for dansk lokalisation
    final dayName = weekdayFormat.format(date.toLocal());
    // print(dayName);
    return _capitalizeFirstLetter(dayName);
  }

  String _capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
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
