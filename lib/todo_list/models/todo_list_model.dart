class TodoListModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  TodoListModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  TodoListModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoListModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
