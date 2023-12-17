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
}
