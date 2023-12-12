import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo/bloc/exports.dart';
import 'package:equatable/equatable.dart';
import '../../model/exports.dart';

part 'todos_filter_event.dart';
part 'todos_filter_state.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState> {
  final TodosBloc todosBloc;
  late StreamSubscription todosSubscription;

  TodosFilterBloc({required this.todosBloc}) : super(TodosFilterLoading()) {
    // Configure _onUpdateTodos to run when UpdateTodos events come in
    on<UpdateTodos>(_onUpdateTodos);
    on<UpdateFilter>(_onUpdateFilter);

    // Add a listener for all todo updates
    todosSubscription = todosBloc.stream.listen((state) {
      add(const UpdateFilter());
    });
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<TodosFilterState> emit) {
    if (state is TodosFilterLoading) {
      add(const UpdateTodos(filter: TodosFilter.pending));
    }

    if (state is TodosFilterLoaded) {
      final state = this.state as TodosFilterLoaded;
      add(UpdateTodos(filter: state.filter));
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosFilterState> emit) {
    final state = todosBloc.state;

    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.filter) {
          case TodosFilter.all:
            return true;
          case TodosFilter.completed:
            return todo.isCompleted!;
          case TodosFilter.canceled:
            return todo.isCanceled!;
          case TodosFilter.pending:
            return !(todo.isCanceled! || todo.isCompleted!);
        }
      }).toList();

      emit(TodosFilterLoaded(todos: todos, filter: event.filter));
    }
  }
}
