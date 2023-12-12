import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodos);
    // on<DeleteTodo>(_onDeleteTodos);
    // on<UpdateTodo>(_onUpdateTodos);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    emit(TodosLoaded(todos: event.todos));
  }

  void _onAddTodos(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(TodosLoaded(todos: [...state.todos, event.todo]));
    }
  }

  // void _onDeleteTodos(DeleteTodo event, Emitter<TodosState> emit) {
  //   Todo.todos.remove(event.todo);
  //   emit(TodosLoaded(todos: Todo.todos));
  // }

  // void _onUpdateTodos(UpdateTodo event, Emitter<TodosState> emit) {
  //   final index = Todo.todos.indexWhere((element) => element.id == event.todo.id);
  //   Todo.todos[index] = event.todo;
  //   emit(TodosLoaded(todos: Todo.todos));
  // }
}
