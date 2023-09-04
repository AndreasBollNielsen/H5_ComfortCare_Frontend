import 'dart:async';
import 'dart:convert';
// import 'dart:html';
//import 'package:crypto/crypto.dart';

import 'package:flutter_comfortcare/Model/ResponseBody.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import '../Model/Employee.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart' as rsa;
import 'package:encrypt/encrypt.dart';

class ApiClient {
  //url to api
  // final String baseUrl = 'http://halberg.it/api/Login/Employee';
  final String baseUrl = 'http://192.168.0.180:5270/api/Login/';
  var key;
  var iv;

  ApiClient();

  //method to call the api
  Future<APIResponse> login(Employee employee) async {
    var url = Uri.parse('${baseUrl}GetKey');
    var data = jsonEncode(employee.toJson());

    try {
      //Get public key
      

     
        //get pem string from body
       

        //convert pem string to public RSA key
      
       
        //generate AES keys
       

        //convert keys to bytes
       

        //initialize encrypter
        final encryptor = OAEPEncoding(RSAEngine())..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));

         //encrypt key & Iv 
        

        //convert to based64 string
       

        //send encrypted data to api
        url = Uri.parse('${baseUrl}SetAESKeys');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'key': , 'iv': }),
        );

        // encrypt data symmetrically
        if (response.statusCode == 200) {
          final encryptor = Encrypter(AES(key, mode: AESMode.cbc));
          final encryptedData = encryptor.encrypt(data, iv: iv);

          data = json.encode({'data': encryptedData.base64});
        }
      

      //send encrypted data
      url = Uri.parse('${baseUrl}Employee');
      final response = await http
          .post(url, headers: {'Content-Type': 'application/json'}, body: data)
          .timeout(Duration(seconds: 100));

      if (response.statusCode == 200) {
        final result = await response.body;
        final String? jwtToken = response.headers['authorization'];

        //decrypt data
        final encryptedData = Encrypted.fromBase64(result);
        final encryptor = Encrypter(AES(key, mode: AESMode.cbc));
        final decryptedData = encryptor.decrypt(encryptedData, iv: iv);

        final parsed = jsonDecode(decryptedData) as Map<String, dynamic>;
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
    } on TimeoutException {
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
