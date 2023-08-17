import 'package:flutter/material.dart';
import '../Widgets/MainPageContent.dart'; // Import your MainPageContent widget
import '../Widgets/DayColumn.dart'; // Import your DayColumn widget
import '../Model/Task.dart'; // Import your Task model

class WorkSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MainPageContent(
    //   content: SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: Row(
    //       children: [
    //         for (int i = 0; i < 7; i++)
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.pushNamed(
    //                 context,
    //                 '/daySchedule',
    //                 arguments: {'dayIndex': i},
    //               );
    //             },
    //             child: DayColumn(
    //               dayName: getDayName(i),
    //               tasks: getTasksForDay(i),
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    //   showBackButton: true, // Show the back button in the app bar
    //   isLoggedIn:
    //       true, // Assuming the user is logged in when viewing the work schedule
    // );
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < 7; i++)
              DayColumn(
                dayName: getDayName(i),
                tasks: getTasksForDay(i),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method to get the day name
  String getDayName(int index) {
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

  List<Task> getTasksForDay(int index) {
    // Implement your logic to fetch tasks for the given day index
    // Return a list of Task objects
    // Example:
    return List.generate(
      15,
      (index) => Task(
        title: 'SOSU',
        timeSpan: 30,
        startDate: DateTime.now(), // Replace with the actual start time
        endDate: DateTime.now()
            .add(Duration(hours: 1)), // Replace with the actual end time
        address: '123 Street',
        citizenName: 'John Doe',
        description: 'Sample task description',
      ),
    );
  }
}
