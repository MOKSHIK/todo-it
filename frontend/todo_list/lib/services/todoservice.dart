import 'dart:convert';
import "cacheservice.dart";
import 'package:http/http.dart' as http;
import 'package:todo_list/routes/apiroutes.dart';

class TodoServices {
  static var todoList = [];
  static getUserName() async {
    CacheService cache = CacheService();
    var client = http.Client();
    var id = await cache.readCache(key: 'id');
    var jwt = await cache.readCache(key: 'jwt');
    var url = Uri.parse(APIRoutes.apiUrl + APIRoutes.userIDAPI + id);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Authorization": 'Bearer $jwt'
    };
    var response = await client.get(url, headers: headers);
    var data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  static getUserTodo() async {
    CacheService cache = CacheService();
    var client = http.Client();
    var id = await cache.readCache(key: 'id');
    var jwt = await cache.readCache(key: 'jwt');
    var url = Uri.parse(APIRoutes.apiUrl + APIRoutes.usertodoAPI + id);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Authorization": 'Bearer $jwt'
    };
    var response = await client.get(url, headers: headers);
    var data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  static deleteUserTodo(String todoID) async {
    CacheService cache = CacheService();
    var client = http.Client();
    var jwt = await cache.readCache(key: 'jwt');
    var url = Uri.parse('${APIRoutes.apiUrl}${APIRoutes.usertodoAPI}delete');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Authorization": 'Bearer $jwt'
    };
    var body = jsonEncode({'todoID': todoID});
    var response = await client.delete(url, headers: headers, body: body);
    var data = json.decode(response.body) as Map<String, dynamic>;
    return data;
  }

  static addUserTodo(String task) async {
    CacheService cache = CacheService();
    var client = http.Client();
    var id = await cache.readCache(key: 'id');
    var jwt = await cache.readCache(key: 'jwt');
    var url = Uri.parse('${APIRoutes.apiUrl}${APIRoutes.usertodoAPI}add');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Authorization": 'Bearer $jwt'
    };
    var body = jsonEncode({'userID': id, 'task': task});
    var response = await client.post(url, headers: headers, body: body);
    var data = json.decode(response.body) as Map<String, dynamic>;
    todoList.add({"task": data['data']['task'], "_id": data['data']['_id']});
    return data;
  }
}
