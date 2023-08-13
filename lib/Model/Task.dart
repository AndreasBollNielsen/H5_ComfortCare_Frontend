class Task {
  final DateTime startTime;
  final DateTime endTime;
  final String address;
  final String citizenName;
  final String taskDescription;

  Task({
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.citizenName,
    required this.taskDescription,
  });
}
