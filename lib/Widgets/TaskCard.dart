import 'package:flutter/material.dart';
import '../Model/Task.dart'; // Import your Task model

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
                'Time: ${task.startDate.toString()} - ${task.endDate.toString()}'),
            SizedBox(height: 8),
            Text('Address: ${task.address}'),
            SizedBox(height: 8),
            Text('Citizen Name: ${task.citizenName}'),
            SizedBox(height: 8),
            Text('Description: ${task.description}'),
          ],
        ),
      ),
    );
  }
}
