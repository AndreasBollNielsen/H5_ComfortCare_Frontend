import 'package:flutter/material.dart';

import '../Model/Task.dart';
import '../Widgets/TaskCard.dart';

class DayTaskPage extends StatelessWidget {
  final Task task;
  DayTaskPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TaskCard(task: task),
    );
  }
}
