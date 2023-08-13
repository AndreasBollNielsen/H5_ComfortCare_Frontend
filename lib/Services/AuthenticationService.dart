import 'APIService.dart';

class AuthService {
  final ApiClient apiClient = ApiClient();
  bool _isLoggedin = false;

  AuthService();

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
