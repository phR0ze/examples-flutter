part of 'todos_filter_bloc.dart';

sealed class TodosFilterState extends Equatable {
  const TodosFilterState();

  @override
  List<Object> get props => [];
}

final class TodosFilterLoading extends TodosFilterState {}

final class TodosFilterLoaded extends TodosFilterState {
  final List<Todo> todos;
  final TodosFilter filter;

  const TodosFilterLoaded({
    required this.todos,
    this.filter = TodosFilter.all,
  });

  @override
  List<Object> get props => [todos, filter];
}
