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
          await apiService.login(Employee(name: userName, password: password));

      if (response.statusCode == 200) {
        await repoService.storeWeekplan(response.body);
        _isLoggedin = true;
      } else if (response.statusCode == 500) {}

      return response;
    } catch (e) {
      print('An error occurred during login: $e');
    }
  }

  void Logout() {
    _isLoggedin = false;
  }

  Future<bool> checkUserLogin() async {
    if (await this.repoService.GetUserInitials()) {
      return true;
    } else {
      return false;
    }
  }
}
