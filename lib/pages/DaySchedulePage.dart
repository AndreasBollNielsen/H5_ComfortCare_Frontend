import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Services/InactivityService.dart';
import 'package:flutter_comfortcare/Widgets/DayColumn.dart';
import '../Widgets/TaskCard.dart';
import '../Model/Task.dart';
import '../Services/RepositoryService.dart';

class DaySchedulePage extends StatelessWidget {
  //final int dayIndex;
  final ReposService reposService;
  final AutoLogoutService inactivityService;
  late List<Task> tasks = [];
  DaySchedulePage(
      {required this.reposService,
      required this.inactivityService,
      required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Wrap(
              children: [
                for (Task task in tasks)
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, '/dayTask',
                          arguments: {'task': task}),
                      inactivityService.ResetTimer()
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: MediaQuery.of(context).size.height * 0.26,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${task.GetDateHourFormatted(task.startDate)} - ${task.GetDateHourFormatted(task.endDate)}',
                            ),
                            SizedBox(height: 8),
                            Text(
                              task.title,
                              // style: TextStyle(
                              //   fontSize: 16,
                              // ),
                            ),
                            Text('${task.citizenName}'),
                            SizedBox(height: 8),
                            Text(
                              '${task.address.streetName}${task.address.localArea.isNotEmpty ? ',${task.address.localArea}' : ''}\n${task.address.city}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Task>> getTasksForDay(int index) async {
    // final now = DateTime.now();
    // final dayIndex = (now.weekday + index) % 7;

    //first implementation of repoService
    var schedule = await this.reposService.GetDaySchedule();

    return schedule![index].tasks;
  }
}
