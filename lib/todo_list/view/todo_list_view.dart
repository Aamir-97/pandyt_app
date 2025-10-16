import 'package:flutter/material.dart';
import 'package:pandyt_app/todo_list/provider/todo_list_pro.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.todoItems.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(value.todoItems[index].title));
          },
        );
      },
    );
  }
}
