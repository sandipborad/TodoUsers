import 'package:doshaheen/model/user.dart';
import 'package:doshaheen/service/todoservice.dart';
import 'package:flutter/material.dart';


class UserToDoProvider with ChangeNotifier {

  final ToDoService _practicalService = ToDoService();

  Map<int, dynamic> _userIdMap = {};
  Map<int, dynamic> get userIdMap => _userIdMap;

  ///Get users
  Future<List<User>> getUsers() async {
    List<User> usersList = [];
    try {
      usersList = await _practicalService.getTodoUsers();
    } catch (error,stacktrace) {
      debugPrint("Stacktrace provider ${stacktrace.toString()}");
      usersList = [];
      notifyListeners();
      throw error;
    }
    _updateUserList(usersList);
    return usersList;
  }

  ///Update user list
  _updateUserList(List<User> userList) async {
    _userMapList(userList);
    notifyListeners();
  }

  ///Map every user with tasks
  _userMapList(List<User> userList) {
    _userIdMap = {};
    for (var element in userList) {
         var data = {};
         var completed = userList.where((e) => e.userId == element.userId && e.completed == true).length;
         var pending = userList.where((e) => e.userId == element.userId && e.completed == false).length;
         data['completed'] = completed;
         data['pending'] = pending;
         data['userId'] = element.userId;
         _userIdMap[element.userId!] = data;
    }

    notifyListeners();
  }
}
