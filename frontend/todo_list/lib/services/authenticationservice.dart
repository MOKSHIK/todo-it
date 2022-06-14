import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_list/routes/apiroutes.dart';

class Authentication {
  static Future<dynamic> login(String email, String password) async {
    var client = http.Client();
    var url = Uri.parse(APIRoutes.apiUrl + APIRoutes.loginAPI);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };
    var body = jsonEncode({'email': email, 'password': password});
    var response = await client.post(url, headers: headers, body: body);
    var jsonData = json.decode(response.body) as Map<String, dynamic>;
    return jsonData;
  }

  static Future<dynamic> register(
      String email, String username, String password) async {
    var client = http.Client();
    var url = Uri.parse(APIRoutes.apiUrl + APIRoutes.registerAPI);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };
    var body =
        jsonEncode({'name': username, 'email': email, 'password': password});
    var response = await client.post(url, headers: headers, body: body);
    var jsonData = json.decode(response.body) as Map<String, dynamic>;
    return jsonData;
  }
}
