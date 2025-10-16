import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/app_layout/custom_appbar.dart';
import 'package:pandyt_app/pages/todo_list/models/todo_list_model.dart';
import 'package:pandyt_app/pages/todo_list/provider/todo_list_provider.dart';
import 'package:provider/provider.dart';

class TodoEditView extends StatefulWidget {
  final int todoId;
  const TodoEditView({super.key, required this.todoId});

  @override
  State<TodoEditView> createState() => _TodoEditViewState();
}

class _TodoEditViewState extends State<TodoEditView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Consumer<TodoListProvider>(
        builder: (context, value, child) {
          TodoListModel? todo;
          todo = value.getTodoById(widget.todoId);
          if (todo != null) {
            _titleController.text = todo.title;
            _descriptionController.text = todo.description;
          } else {
            return const Center(child: Text('To-Do item not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  controller: _titleController,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  controller: _descriptionController,
                ),
                SizedBox(height: 20),
                Text('Status: ${todo.isCompleted ? "Completed" : "Pending"}'),
                SizedBox(height: 20),
                Text('Created At: ${todo.createdAt}'),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Delete')),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        value.todoItems[widget.todoId] = value
                            .todoItems[widget.todoId]
                            .copyWith(isCompleted: true);
                      },
                      child: Text('Mark as Done'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Save action
                        todo = todo!.copyWith(
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
        child: Container(),
      ),
    );
  }
}
