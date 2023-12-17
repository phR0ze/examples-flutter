// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../model/todo_filter.dart';

// // Generated riverpod code for todosProvider
// part 'todo_filter.g.dart';

// // Defines todosProvider notifier to make it writable
// @riverpod
// class TodoFilter extends _$Todos {
//   // Define the initial value for the provider
//   @override
//   Future<List<Todo>> build() async {
//     return Future.delayed(const Duration(seconds: 2), () {
//       return const [
//         Todo(
//           id: '1',
//           title: 'Example Todo 1',
//           description: 'Description 1',
//         ),
//         Todo(
//           id: '2',
//           title: 'Example Todo 2',
//           description: 'Description 2',
//         ),
//         Todo(
//           id: '3',
//           title: 'Example Todo 3',
//           description: 'Description 3',
//         ),
//       ];
//     });
//   }

//   // Add a new todo to our internal state
//   Future<void> add(Todo todo) async {
//     state = AsyncData([...state.value!, todo]);
