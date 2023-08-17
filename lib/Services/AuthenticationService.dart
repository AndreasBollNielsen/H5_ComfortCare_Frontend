import 'package:flutter_comfortcare/Model/Employee.dart';

import 'APIService.dart';

class AuthService {
  final ApiClient _apiService = ApiClient();
  bool _isLoggedin = false;

  AuthService();

  Future<bool> login(String userName, String password) async {
    try {
      final response =
          await _apiService.login(Employee(name: userName, password: password));

      _isLoggedin = response;
      return _isLoggedin;
    } catch (e) {
      print('An error occurred during login: $e');
      return false;
    }
  }
}
