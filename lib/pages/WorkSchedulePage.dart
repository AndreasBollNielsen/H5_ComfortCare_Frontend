import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Model/DayTasks.dart';
import '../Widgets/MainPageContent.dart'; // Import your MainPageContent widget
import '../Widgets/DayColumn.dart'; // Import your DayColumn widget
import '../Model/Task.dart'; // Import your Task model
import '../Services/RepositoryService.dart';

class WorkSchedulePage extends StatelessWidget {
  final ReposService reposService;
  late List<DayTasks> schedule;
  WorkSchedulePage({required this.reposService});

  Future<List<DayTasks>> fetchSchedule() async {
    final currentschedule = await reposService.GetDaySchedule();
    schedule = currentschedule!;
    return schedule ?? []; // Returner en tom liste, hvis schedule er null
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DayTasks>>(
      future: fetchSchedule(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator()); // Vis en loading-indikator, mens data hentes
        } else if (snapshot.hasError) {
          return Text('An error occurred: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<DayTasks> schedule = snapshot.data!;

          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < 7; i++)
                    DayColumn(
                      dayName: getDayName(i),
                      tasks: schedule[i].tasks,
                    ),
                ],
              ),
            ),
          );
        } else {
          return Text('No data available.');
        }
      },
    );
  }

  // Helper method to get the day name
  String getDayName(int index) {
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

    return schedule[index].day;
  }

  List<Task> getTasksForDay(int index) {
    return schedule[index].tasks;

    // Implement your logic to fetch tasks for the given day index
    // Return a list of Task objects
    // Example:
    // return List.generate(
    //   15,
    //   (index) => Task(
    //     title: 'SOSU',
    //     timeSpan: 30,
    //     startDate: DateTime.now(), // Replace with the actual start time
    //     endDate: DateTime.now()
    //         .add(Duration(hours: 1)), // Replace with the actual end time
    //     address: '123 Street',
    //     citizenName: 'John Doe',
    //     description: 'Sample task description',
    //   ),
    // );
  }
}
