import 'dart:convert';
import 'package:doshaheen/config/appconfig.dart';
import 'package:doshaheen/model/user.dart';
import 'package:http/http.dart' show Client;


class ToDoService {

  static const String _baseUrl = AppConfig.BASE_URL;
  final Client _http = Client();

  ///Get users
  Future<List<User>> getTodoUsers() async {
    try {
      List<User>? userList = [];

      var url = Uri.https(_baseUrl, "/todos");
      final response = await _http.get(url);

      final list = json.decode(response.body) as List<dynamic>;
      List<User> output = list.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
      userList = output;

      return userList;
    }  catch (error) {
      throw error;
    }
  }
}
