import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/exports.dart' as model;

// Generated riverpod code
part 'todo.g.dart';

// Defines an async `todoProvider` Notifier to manage the state of our todos
@riverpod
class Todo extends _$Todo {
  @override
  Future<List<model.Todo>> build() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return const [
        model.Todo(
          id: '1',
          title: 'Example Todo 1',
          description: 'Description 1',
        ),
        model.Todo(
          id: '2',
          title: 'Example Todo 2',
          description: 'Description 2',
        ),
        model.Todo(
          id: '3',
          title: 'Example Todo 3',
          description: 'Description 3',
        ),
      ];
    });
  }

  // Add a new todo to our internal state
  Future<void> add(model.Todo todo) async {
    state = AsyncData([...state.value!, todo]);
  }

  // Mark the todo completed in our internal state
  Future<void> complete(model.Todo todo) async {
    state = AsyncData(
        state.value!.map((x) => x.id == todo.id ? todo.copyWith(isCompleted: true) : x).toList());
  }

  // Replace the todo in our internal state with the new todo
  Future<void> replace(model.Todo todo) async {
    state = AsyncData(state.value!.map((x) => x.id == todo.id ? todo : x).toList());
  }

  // Delete the todo from our internal state
  Future<void> delete(model.Todo todo) async {
    state = AsyncData(state.value!.where((x) => x.id != todo.id).toList());
  }
}
