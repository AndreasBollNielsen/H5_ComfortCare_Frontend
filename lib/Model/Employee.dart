class Employee {
  final String name;
  final String password;

  Employee({required this.name, required this.password});

//convert data to json structure
  Map<String, dynamic> toJson() {
    return {
      'initials': name,
      'password': password,
    };
  }
}
