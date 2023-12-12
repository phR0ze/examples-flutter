part of 'todos_bloc.dart';

sealed class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

final class TodosLoading extends TodosState {}

// Defined for when the todos are loaded
final class TodosLoaded extends TodosState {
  final List<Todo> todos;

  const TodosLoaded({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
