part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent {
  final List<Todo> todos;

  const LoadTodos({this.todos = const <Todo>[]});
}

class AddTodo extends TodosEvent {
  final Todo todo;

  const AddTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodosEvent {
  final Todo todo;

  const UpdateTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  const DeleteTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}
