import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Model/DayTasks.dart';
import '../Widgets/MainPageContent.dart';
import '../Widgets/DayColumn.dart';
import '../Model/Task.dart';
import '../Services/RepositoryService.dart';

class WorkSchedulePage extends StatelessWidget {
  final ReposService reposService;
  late List<DayTasks> schedule;
  WorkSchedulePage({required this.reposService});

  Future<List<DayTasks>> fetchSchedule() async {
    final currentschedule = await reposService.GetDaySchedule();
    schedule = currentschedule!;
    return schedule ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DayTasks>>(
      future: fetchSchedule(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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
    return schedule[index].day;
  }

  //get single task for the day
  List<Task> getTasksForDay(int index) {
    return schedule[index].tasks;
  }
}
