import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/todo_list/models/todo_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListProvider extends ChangeNotifier {
  final List<TodoListModel> _todoItems = [];

  List<TodoListModel> get todoItems => List.unmodifiable(_todoItems);

  /// Loads todo items from SharedPreferences
  Future<void> loadTodoItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('todo_items');

    _todoItems.clear();

    if (jsonString != null) {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      _todoItems.addAll(
        decodedList.map((e) => TodoListModel.fromJson(e)).toList(),
      );
    }

    notifyListeners();
  }

  /// Saves all todo items to SharedPreferences
  Future<void> _saveTodoItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = _todoItems
        .map((item) => item.toJson())
        .toList();
    await prefs.setString('todo_items', jsonEncode(jsonList));
  }

  /// Updates an existing todo item by its ID and persists the change
  Future<void> updateTodoItem(TodoListModel updatedItem) async {
    final index = _todoItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _todoItems[index] = updatedItem;
      await _saveTodoItems();
      notifyListeners();
    }
  }

  /// Adds a new todo item and persists changes
  Future<void> addTodoItem(TodoListModel item) async {
    _todoItems.add(item);
    await _saveTodoItems();
    notifyListeners();
  }

  /// Removes a todo item and persists changes
  Future<void> removeTodoItem(int index) async {
    if (index < 0 || index >= _todoItems.length) return;
    _todoItems.removeAt(index);
    await _saveTodoItems();
    notifyListeners();
  }

  TodoListModel? getTodoById(int? id) {
    return _todoItems.firstWhere(
      (item) => item.id == id,
      orElse: () =>
          TodoListModel(id: -1, title: '', isCompleted: false, description: ''),
    );
  }

  int getTodoLastId() => _todoItems.isEmpty ? 0 : _todoItems.last.id;
}
