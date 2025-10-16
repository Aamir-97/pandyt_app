import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/todo_list/models/todo_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListProvider extends ChangeNotifier {
  final List<TodoListModel> _todoItems = [];

  List<TodoListModel> get todoItems => _todoItems;

  Future<void> loadTodoItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    final keys = prefs.getKeys().where((k) => k.startsWith('todo_'));
    _todoItems.clear();

    for (var key in keys) {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        final Map<String, dynamic> jsonData = jsonDecode(jsonString);
        _todoItems.add(TodoListModel.fromJson(jsonData));
      }
    }
    notifyListeners();
  }

  void addTodoItem(TodoListModel item) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // // Convert to JSON string
    // String todoString = jsonEncode(item.toJson());

    // // Save under a unique key
    // await prefs.setString('todo_${item.id}', todoString);
    _todoItems.add(item);
    notifyListeners();
  }

  void removeTodoItem(int index) {
    _todoItems.removeAt(index);
    notifyListeners();
  }

  TodoListModel? getTodoById(int? id) {
    final items = _todoItems.where((item) => item.id == id);
    return items.isNotEmpty ? items.first : null;
  }

  int getTodoLastId() {
    if (_todoItems.isEmpty) return 0;
    return _todoItems.last.id;
  }
}
