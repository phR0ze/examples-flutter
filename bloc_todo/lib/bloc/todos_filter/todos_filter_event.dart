part of 'todos_filter_bloc.dart';

sealed class TodosFilterEvent extends Equatable {
  const TodosFilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends TodosFilterEvent {
  const UpdateFilter();

  @override
  List<Object> get props => [];
}

class UpdateTodos extends TodosFilterEvent {
  final TodosFilter filter;

  const UpdateTodos({this.filter = TodosFilter.all});

  @override
  List<Object> get props => [filter];
}
