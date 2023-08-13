import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl = 'https://catfact.ninja/fact';

  ApiClient();

  Future<String> login(String endpoint) async {
    final url = Uri.parse(baseUrl);
    
    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }
}
