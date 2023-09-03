import 'package:flutter_comfortcare/Model/Employee.dart';
import 'package:flutter_comfortcare/Services/RepositoryService.dart';
import '../Model/ResponseBody.dart';
import 'package:flutter/material.dart';
import 'APIService.dart';

class AuthService {
  final ApiClient apiService;
  final ReposService repoService;
  bool _isLoggedin = false;

  AuthService({required this.apiService, required this.repoService});

  // method returns response data from api
  Future<APIResponse?> login(String userName, String password) async {
    try {
      final response =
          await apiService.login(Employee(name: 'RoMo', password: 'Kode1234!'));

      //if user is validated, data is stored locally
      if (response.statusCode == 200) {
        if (response.jwt == null) {
          response.jwt = 'test';
        }
        await repoService.storeWeekplan(response.body, response.jwt!, userName);
        _isLoggedin = true;
      }

      //return response data
      return response;
    } catch (e) {
      print('An error occurred during login: $e');
    }
    return null;
  }

  //log out user
  void Logout(BuildContext context) {
    _isLoggedin = false;

    //pop all stacks until first route
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/login');
  }

  //checks login status
  bool CheckLoginStatus() {
    return _isLoggedin;
  }

  //logs the user in with their credentials are present in securestorage
  Future<bool> checkUserLogin(Employee user) async {
    if (await this.repoService.GetUserInitials(user)) {
      _isLoggedin = true;
      return true;
    } else {
      return false;
    }
  }
}
