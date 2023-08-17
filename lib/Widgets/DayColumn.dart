import 'package:flutter/material.dart';
import '../Model/Task.dart'; // Import the Task class

class DayColumn extends StatelessWidget {
  final String dayName;
  final List<Task> tasks;

  DayColumn({required this.dayName, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/daySchedule',
          arguments: {'day': this.dayName, 'dayIndex': 0}),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dayName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  for (Task task in tasks)
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/dayTask',
                          arguments: {'task': task}),
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.description,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(task.startDate.toString()),
                            SizedBox(height: 8),
                            Text(task.endDate.toString()),
                            SizedBox(height: 8),
                            Text(task.address)
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
