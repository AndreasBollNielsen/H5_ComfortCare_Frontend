import 'Task.dart';

class DayTasks {
  final String day;
  final String name;
  final List<Task> tasks;

  DayTasks({required this.day, required this.tasks, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'name': name,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  factory DayTasks.fromJson(Map<String, dynamic> json) {
    return DayTasks(
      day: json['day'],
      name: json['name'],
      tasks: (json['tasks'] as List<dynamic>)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList(),
    );
  }
}
