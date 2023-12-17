import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/todo.dart';

// Generated riverpod code for todosProvider
part 'todos.g.dart';

// Defines todosProvider notifier to make it writable
@riverpod
class Todos extends _$Todos {
  // Define the initial value for the provider
  @override
  Future<List<Todo>> build() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return const [
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
    });
  }

  // Add a new todo to our internal state
  Future<void> add(Todo todo) async {
    state = AsyncData([...state.value!, todo]);
  }

  // Replace the todo in our internal state with the new todo
  Future<void> replace(Todo todo) async {
    state = AsyncData(state.value!.map((x) => x.id == todo.id ? todo : x).toList());
  }

  // Delete the todo from our internal state
  Future<void> delete(Todo todo) async {
    state = AsyncData(state.value!.where((x) => x.id != todo.id).toList());
  }
}
