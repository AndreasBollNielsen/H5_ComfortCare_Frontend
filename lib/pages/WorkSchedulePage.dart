import 'package:flutter/material.dart';

class Task {
  final String title;
  final String time;
  final String street;
  final String zipcode;
  final String city;

  Task({
    required this.title,
    required this.time,
    required this.street,
    required this.zipcode,
    required this.city,
  });
}

class DayColumn extends StatelessWidget {
  final String dayName;
  final List<Task> tasks;

  DayColumn({required this.dayName, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            dayName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Column(
            children: [
              for (Task task in tasks)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(task.time),
                      SizedBox(height: 8),
                      Text(task.street),
                      Text('${task.zipcode} ${task.city}'),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.95,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < 7; i++)
              ListView(
                shrinkWrap: true,
                children: [
                  DayColumn(
                    dayName: getDayName(i),
                    tasks: List.generate(
                      15,
                      (index) => Task(
                        title: 'Task ${index + 1}',
                        time: '08:00 - 08:30',
                        street: '123 Street',
                        zipcode: '12345',
                        city: 'City A',
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String getDayName(int index) {
    final now = DateTime.now();
    final dayIndex = (now.weekday + index) % 7;
    return ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][dayIndex];
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Work Schedule'),
      ),
      body: WorkSchedulePage(),
    ),
  ));
}
