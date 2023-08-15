import 'package:flutter/material.dart';
import '../Widgets/MainPageContent.dart'; // Import your MainPageContent widget
import '../Widgets/TaskCard.dart'; // Import your TaskCard widget
import '../Model/Task.dart'; // Import your Task model

class DaySchedulePage extends StatelessWidget {
  final int dayIndex;

  DaySchedulePage({required this.dayIndex});

  @override
  Widget build(BuildContext context) {
    String dayName = getDayName(dayIndex);
    List<Task> tasks = getTasksForDay(dayIndex);

    // return MainPageContent(
    //   content: ListView(
    //     children: [
    //       for (Task task in tasks)
    //         TaskCard(task: task), // Use the TaskCard widget for each task
    //     ],
    //   ),
    //   showBackButton: true,
    //   isLoggedIn: true,
    // );

    return Container(
      child: ListView(
        children: [
          for (Task task in tasks)
            TaskCard(task: task), // Use the TaskCard widget for each task
        ],
      ),
      // showBackButton: true,
      // isLoggedIn: true,
    );
  }

  // Helper methods for fetching day's tasks and name
  String getDayName(int index) {
    final now = DateTime.now();
    final dayIndex = (now.weekday + index) % 7;
    return [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ][dayIndex];
  }

  List<Task> getTasksForDay(int index) {
    final now = DateTime.now();
    final dayIndex = (now.weekday + index) % 7;

    // Replace this with your logic to fetch tasks based on the day index
    // Example: You might have a list of tasks that you fetch from a data source
    List<Task> tasks = [
      Task(
        startTime: DateTime.now(), // Replace with the actual start time
        endTime: DateTime.now()
            .add(Duration(hours: 1)), // Replace with the actual end time
        address: '123 Street',
        citizenName: 'John Doe',
        taskDescription: 'Sample task description',
      ),
      // Add more tasks as needed
    ];

    return tasks;
  }
}
