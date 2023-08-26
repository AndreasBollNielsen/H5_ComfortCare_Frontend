import 'dart:async';
import 'dart:convert';
import 'package:flutter_comfortcare/Model/ResponseBody.dart';
import 'package:http/http.dart' as http;
import '../Model/Employee.dart';

class ApiClient {
  //home ip
  final String baseUrl = 'http://192.168.0.180:5270/api/Login/Employee';

  //schoolIp
  // final String baseUrl ='http://10.108.137.227:5270/api/Test/LoginTestEmployee';

  //server
  // final String baseUrl ='https://cc-api.nas.bavnely.dk/api/Test/LoginTestEmployee';

  ApiClient();

  Future<APIResponse> login(Employee employee) async {
    final url = Uri.parse(baseUrl);
    final data = jsonEncode(employee.toJson());

    try {
      final response = await http
          .post(url, headers: {'Content-Type': 'application/json'}, body: data)
          .timeout(Duration(seconds: 3));
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final result = await response.body;
        final String? jwtToken = response.headers['authorization'];
        final parsed = jsonDecode(result) as Map<String, dynamic>;
        return APIResponse(
            body: parsed,
            statusCode: response.statusCode,
            message: '',
            jwt: jwtToken);
      } else {
        final Map<String, dynamic> nullObject = {};
        return APIResponse(
            body: nullObject,
            statusCode: response.statusCode,
            message: 'Error: ${response.statusCode} Not Found');
      }
    } on TimeoutException catch (e) {
      final Map<String, dynamic> timeoutError = {};
      return APIResponse(
          body: timeoutError,
          statusCode: 500,
          message: 'Connection timed out. Please try again later.');
    } catch (e) {
      print(e);
      print(e);
      final Map<String, dynamic> errorResponse = {'error': e.toString()};
      return APIResponse(
          body: errorResponse,
          statusCode: 503,
          message: 'oops something went wrong');
    }
  }
}
