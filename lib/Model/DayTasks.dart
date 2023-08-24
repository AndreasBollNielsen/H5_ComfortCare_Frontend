import 'Task.dart';

class DayTasks {
  final String day;
  final String name;
  final List<Task> tasks;

  DayTasks({required this.day, required this.tasks, required this.name});

  //method to convert model to json data
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'name': name,
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  //factory to convert from json data to model
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
