import 'package:flutter/material.dart';
import 'package:pandyt_app/todo_list/models/todo_list_model.dart';
import 'package:pandyt_app/todo_list/provider/todo_list_pro.dart';
import 'package:provider/provider.dart';

class TodoEditView extends StatefulWidget {
  final String? todoId;
  const TodoEditView({super.key, this.todoId});

  @override
  State<TodoEditView> createState() => _TodoEditViewState();
}

class _TodoEditViewState extends State<TodoEditView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListProvider>(
      builder: (context, value, child) {
        TodoListModel? todo;
        if (widget.todoId != null) {
          todo = value.getTodoById(widget.todoId);
        }

        return Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(
                text: todo != null ? todo.title : '',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              controller: TextEditingController(
                text: todo != null ? todo.description : '',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Due Date:'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Show date picker
                  },
                  child: Text('Select Date'),
                ),
                Spacer(),
                ElevatedButton(onPressed: () {}, child: Text('Delete')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, child: Text('Mark as Done')),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Save action
                  },
                  child: Text('Save'),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        );
      },
      child: Container(),
    );
  }
}
