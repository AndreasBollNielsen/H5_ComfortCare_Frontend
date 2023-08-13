import 'package:flutter/material.dart';
import '../Widgets/MainPageContent.dart';
import '../Widgets/TaskCard.dart';
import '../Model/Task.dart';

class DaySchedulePage extends StatelessWidget {
  final int dayIndex;

  DaySchedulePage({required this.dayIndex});

  @override
  Widget build(BuildContext context) {
    String dayName = getDayName(dayIndex);
    List<Task> tasks = getTasksForDay(dayIndex);

    return MainPageContent(
      content: ListView(
        children: [
          for (Task task in tasks) TaskCard(task),
        ],
      ),
    );
  }

  // Helper methods for fetching day's tasks and name
  String getDayName(int index) {
    final now = DateTime.now();
    final dayIndex = (now.weekday + index) % 7;
    return ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][dayIndex];
  }

  List<Task> getTasksForDay(int index) {
    // Simulate fetching tasks from a data source
    return List.generate(
      15,
      (index) => Task(
        title: 'Task ${index + 1}',
        time: '08:00 - 08:30',
        street: '123 Street',
        zipcode: '12345',
        city: 'City A',
      ),
    );
  }
}
