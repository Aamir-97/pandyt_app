class TodoListModel {
  final int id;
  final String title;
  final String description;
  final String? createdAt;
  final bool isCompleted;

  TodoListModel({
    required this.id,
    required this.title,
    required this.description,
    this.createdAt,
    this.isCompleted = false,
  });

  TodoListModel copyWith({
    int? id,
    String? title,
    String? description,
    String? createdAt,
    bool? isCompleted,
  }) {
    return TodoListModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Convert object → JSON map
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt,
    'isCompleted': isCompleted,
  };

  // Convert JSON map → object
  factory TodoListModel.fromJson(Map<String, dynamic> json) => TodoListModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    createdAt: json['createdAt'],
    isCompleted: json['isCompleted'],
  );
}
