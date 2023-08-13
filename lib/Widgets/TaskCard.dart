import 'package:flutter/material.dart';
import '../Model/Task.dart'; // Import the Task class

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            task.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(task.time),
          SizedBox(height: 8),
          Text(task.street),
          Text('${task.zipcode} ${task.city}'),
        ],
      ),
    );
  }
}
