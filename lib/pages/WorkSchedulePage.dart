import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Model/DayTasks.dart';
import '../Widgets/DayColumn.dart';
import '../Model/Task.dart';
import '../Services/RepositoryService.dart';
import '../Services/InactivityService.dart';

class WorkSchedulePage extends StatefulWidget {
  final ReposService reposService;
  final AutoLogoutService inactivityService;

  WorkSchedulePage(
      {required this.reposService, required this.inactivityService});

  @override
  State<WorkSchedulePage> createState() => _WorkSchedulePageState();
}

class _WorkSchedulePageState extends State<WorkSchedulePage> {
  late List<DayTasks> schedule;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      widget.inactivityService.ResetTimer();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<DayTasks>> fetchSchedule() async {
    final currentschedule = await widget.reposService.GetDaySchedule();
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
          widget.inactivityService.context = context;
          widget.inactivityService.ResetTimer();
          return Scaffold(
            body: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < schedule.length; i++)
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: DayColumn(
                        dayName: getDayName(i),
                        tasks: schedule[i].tasks,
                        inactivityService: widget.inactivityService,
                      ),
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
