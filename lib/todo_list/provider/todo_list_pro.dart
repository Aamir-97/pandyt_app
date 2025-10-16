import 'package:flutter/material.dart';
import 'package:pandyt_app/todo_list/models/todo_list_model.dart';

class TodoListProvider extends ChangeNotifier {
  final List<TodoListModel> _todoItems = [];

  List<TodoListModel> get todoItems => _todoItems;

  void addTodoItem(TodoListModel item) {
    _todoItems.add(item);
    notifyListeners();
  }

  void removeTodoItem(int index) {
    _todoItems.removeAt(index);
    notifyListeners();
  }

  TodoListModel? getTodoById(String? id) {
    final items = _todoItems.where((item) => item.id == id);
    return items.isNotEmpty ? items.first : null;
  }
}
