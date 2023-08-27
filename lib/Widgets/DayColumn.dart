import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Services/InactivityService.dart';
import '../Model/Task.dart';

class DayColumn extends StatefulWidget {
  final String dayName;
  final List<Task> tasks;
  final AutoLogoutService inactivityService;

  DayColumn(
      {required this.dayName,
      required this.tasks,
      required this.inactivityService});

  @override
  State<DayColumn> createState() => _DayColumnState();
}

class _DayColumnState extends State<DayColumn> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        //push to next route if tasks exists
        if (this.widget.tasks.length > 0)
          {
            Navigator.pushNamed(context, '/daySchedule',
                arguments: {'tasks': this.widget.tasks})
          },
        widget.inactivityService.ResetTimer()
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
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
            Center(
              child: Text(widget.dayName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: Container(
                  height: 2.0,
                  color: Colors.black,
                  width: 180.0,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  Task task = widget.tasks[index];
                  return GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, '/dayTask',
                          arguments: {'task': task}),
                      widget.inactivityService.ResetTimer()
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        margin: EdgeInsets.only(bottom: 12),
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
                                '${task.GetDateHourFormatted(task.startDate)} - ${task.GetDateHourFormatted(task.endDate)}'),
                            Text(
                              task.title,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${task.address.streetName}${task.address.localArea.isNotEmpty ? ',${task.address.localArea}' : ''}\n${task.address.city}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
