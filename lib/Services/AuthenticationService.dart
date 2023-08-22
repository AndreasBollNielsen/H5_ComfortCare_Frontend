import 'package:flutter_comfortcare/Model/Employee.dart';
import 'package:flutter_comfortcare/Services/RepositoryService.dart';

import '../Model/ResponseBody.dart';
import 'APIService.dart';

class AuthService {
  final ApiClient apiService;
  final ReposService repoService;
  bool _isLoggedin = false;

  AuthService({required this.apiService, required this.repoService});

  Future<APIResponse?> login(String userName, String password) async {
    try {
      final response =
          await apiService.login(Employee(name: 'a', password: 'b'));

      if (response.statusCode == 200) {
        await repoService.storeWeekplan(response.body);
        _isLoggedin = true;
      }

      return response;
    } catch (e) {
      print('An error occurred during login: $e');
    }
  }

  void Logout() {
    _isLoggedin = false;
  }
}
