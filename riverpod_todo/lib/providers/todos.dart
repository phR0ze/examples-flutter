import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/todo.dart';

// part 'todos.g.dart';

// @riverpod
// Future<myFunction(MyFunctionRef ref) {
//   <your logic here>
// }

// Load the todos from persistent storage
final todosProvider = FutureProvider<List<Todo>>((ref) async {
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
});
