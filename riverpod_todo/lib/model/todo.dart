import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool? isCompleted;
  final bool? isCanceled;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isCanceled = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    bool? isCanceled,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCanceled: isCanceled ?? this.isCanceled,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isCompleted, isCanceled];

  static const List<Todo> todos = [
    Todo(
      id: '1',
      title: 'Example Todo 1',
      description: 'Description 1',
    ),
    Todo(
      id: '2',
      title: 'Example Todo 2',
      description: 'Description 2',
    ),
    Todo(
      id: '3',
      title: 'Example Todo 3',
      description: 'Description 3',
    ),
  ];
}
