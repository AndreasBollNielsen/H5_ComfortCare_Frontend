import 'package:flutter/material.dart';
import '../Widgets/MainPageContent.dart';
import '../Widgets/DayColumn.dart'; // Import your DayColumn widget
import '../Model/Task.dart';

class WorkSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainPageContent(
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < 7; i++)
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/daySchedule',
                    arguments: {'dayIndex': i},
                  );
                },
                child: DayColumn(
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
              ),
          ],
        ),
      ),
    );
  }

  // Helper method to get the day name
  String getDayName(int index) {
    final now = DateTime.now();
    final dayIndex = (now.weekday + index) % 7;
    return ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][dayIndex];
  }
}

void main() {
  runApp(MaterialApp(
    home: WorkSchedulePage(),
  ));
}
