import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/todo_list/provider/todo_list_provider.dart';
import 'package:pandyt_app/pages/todo_list/view/todo_edit_view.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoListProvider>(context, listen: false).loadTodoItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListProvider>(
      builder: (context, value, child) {
        if (value.todoItems.isEmpty) {
          return const Center(child: Text('No todo items. Add some!'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: value.todoItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: value.todoItems[index].isCompleted
                  ? Colors.green[100]
                  : Colors.blue[100],
              title: Text(value.todoItems[index].title),
              subtitle: Text(value.todoItems[index].description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      value.updateTodoItem(
                        value.todoItems[index].copyWith(
                          isCompleted: !value.todoItems[index].isCompleted,
                        ),
                      );
                    },
                    icon: value.todoItems[index].isCompleted
                        ? Icon(Icons.check_box_outlined)
                        : Icon(Icons.check_box_outline_blank),
                  ),
                  IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TodoEditView(
                              todoId: value.todoItems[index].id,
                            );
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      value.removeTodoItem(index);
                    },
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}
