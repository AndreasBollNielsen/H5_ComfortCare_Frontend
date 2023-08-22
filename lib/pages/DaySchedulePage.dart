import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Widgets/DayColumn.dart';
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
      child: Wrap(
        children: [
          for (Task task in tasks)
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/dayTask',
                  arguments: {'task': task}),
              // child: TaskCard(
              //     task: task)), // Use the TaskCard widget for each task
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                          '${task.startDate.hour.toString().padLeft(2, '0')}:${task.startDate.minute.toString().padLeft(2, '0')} - ${task.endDate.hour.toString().padLeft(2, '0')}:${task.endDate.minute.toString().padLeft(2, '0')}'),
                      Text(
                        task.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      Text(task.fullAddress)
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
