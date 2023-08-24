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
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          for (Task task in tasks)
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/dayTask',
                  arguments: {'task': task}),
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

    return schedule![index].tasks;
  }
}
