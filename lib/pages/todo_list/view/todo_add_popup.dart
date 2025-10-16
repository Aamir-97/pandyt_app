import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/todo_list/models/todo_list_model.dart';
import 'package:pandyt_app/pages/todo_list/provider/todo_list_provider.dart';
import 'package:provider/provider.dart';

showTodoAddPopup(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TodoListProvider todoListProvider = Provider.of<TodoListProvider>(
    context,
    listen: false,
  );

  saveTodoData() {
    int newId = todoListProvider.getTodoLastId() + 1;
    TodoListModel newItem = TodoListModel(
      id: newId,
      title: titleController.text,
      description: descriptionController.text,
      createdAt: DateTime.now().toIso8601String(),
    );
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      todoListProvider.addTodoItem(newItem);
      Navigator.of(context).pop();
    }
  }

  showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add To-Do Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  saveTodoData();
                }
              },
              controller: titleController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  saveTodoData();
                }
              },
              controller: descriptionController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // You can also handle adding the to-do item here if needed
              saveTodoData();
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
