import 'APIService.dart';
import '/Model/DayTasks.dart';

class ReposService {
  final ApiClient apiClient = ApiClient();
  bool _isLoggedin = false;

  ReposService();

  Future<bool> login(String userName, String password) async {
    try {
      final response = await apiClient.login('fact');
      print('response: $response');
      _isLoggedin = true;
      return _isLoggedin;
    } catch (e) {
      print('An error occurred during login: $e');
      return false;
    }
  }
}
