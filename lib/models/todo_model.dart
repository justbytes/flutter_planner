class Todo {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final bool finished;

  Todo({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.finished,
  });

  Todo copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    bool? finished,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      finished: finished ?? this.finished,
    );
  }

  // Give the specific todo to TodoCubit onChange
  @override
  String toString() =>
      'Todo(name: $name, description: $description, createdAt: $createdAt, finished: $finished)';
}
