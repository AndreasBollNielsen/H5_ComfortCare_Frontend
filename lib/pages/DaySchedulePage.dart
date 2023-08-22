import 'package:flutter/material.dart';
import '../Widgets/TaskCard.dart'; // Import your TaskCard widget
import '../Model/Task.dart'; // Import your Task model
import '../Services/RepositoryService.dart';

class DaySchedulePage extends StatelessWidget {
  final int dayIndex;
  final ReposService reposService;
  late List<Task> tasks = [];
  DaySchedulePage(
      {required this.dayIndex,
      required this.reposService,
      required this.tasks});

  @override
  void initState() {
   // fetchTasksForDay();
  }

  //deprecated
  // Future<void> fetchTasksForDay() async {
  //   tasks = await getTasksForDay(dayIndex);
  //   // setState(() {}); // Opdater widget for at afspejle de hentede opgaver
  // }

  @override
  Widget build(BuildContext context) {
    // String dayName = getDayName(dayIndex);

    return Container(
      child: ListView(
        children: [
          for (Task task in tasks)
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/dayTask',
                    arguments: {'task': task}),
                child: TaskCard(
                    task: task)), // Use the TaskCard widget for each task
        ],
      ),
      // showBackButton: true,
      // isLoggedIn: true,
    );
  }

  // Helper methods for fetching day's tasks and name
  // String getDayName(int index) {
  //   final now = DateTime.now();
  //   final dayIndex = (now.weekday + index) % 7;
  //   return [
  //     'Monday',
  //     'Tuesday',
  //     'Wednesday',
  //     'Thursday',
  //     'Friday',
  //     'Saturday',
  //     'Sunday'
  //   ][dayIndex];
  // }

  Future<List<Task>> getTasksForDay(int index) async {
    final now = DateTime.now();
    final dayIndex = (now.weekday + index) % 7;

    //first implementation of repoService
    var schedule = await this.reposService.GetDaySchedule();
    // Replace this with your logic to fetch tasks based on the day index
    // Example: You might have a list of tasks that you fetch from a data source

    // List<Task> tasks = [
    //   Task(
    //     title: 'SOSU',
    //     timeSpan: 30,
    //     startDate: DateTime.now(), // Replace with the actual start time
    //     endDate: DateTime.now()
    //         .add(Duration(hours: 1)), // Replace with the actual end time
    //     address: '123 Street',
    //     citizenName: 'John Doe',
    //     description: 'Sample task description',
    //   ),
    //   Task(
    //     title: 'SOSU',
    //     timeSpan: 45,
    //     startDate: DateTime.now(), // Replace with the actual start time
    //     endDate: DateTime.now()
    //         .add(Duration(hours: 1)), // Replace with the actual end time
    //     address: '456 Street',
    //     citizenName: 'Jane Doe',
    //     description: 'Sample task description',
    //   ),
    // ];

    //return tasks;
    return schedule![index].tasks;
  }
}
