import 'package:flutter_comfortcare/Model/Employee.dart';
import 'package:flutter_comfortcare/Services/RepositoryService.dart';

import 'APIService.dart';

class AuthService {
  final ApiClient apiService;
  final ReposService repoService;
  bool _isLoggedin = false;

  AuthService({required this.apiService, required this.repoService});

  Future<bool> login(String userName, String password) async {
    try {
      final response =
          await apiService.login(Employee(name: 'a', password: 'b'));

      await repoService.storeWeekplan(response);

      _isLoggedin = true;
      return _isLoggedin;
    } catch (e) {
      print('An error occurred during login: $e');
      return false;
    }
  }
}
