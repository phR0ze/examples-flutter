import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/exports.dart' as model;
import 'providers/exports.dart';
import 'todo_page.dart';
import 'widgets/loading.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod todo example'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              switch (index) {
                case 0:
                  ref.read(todoFilterProvider.notifier).set(model.TodoFilter.pending);
                  break;
                case 1:
                  ref.read(todoFilterProvider.notifier).set(model.TodoFilter.completed);
                  break;
              }
            },
            tabs: const [
              Tab(icon: Icon(Icons.pending)),
              Tab(icon: Icon(Icons.add_task)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Todos('Pending Todos'),
            Todos('Completed Todos'),
          ],
        ),
      ),
    );
  }
}

class Todos extends ConsumerWidget {
  final String title;
  const Todos(this.title, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var asyncValue = ref.watch(todoProvider);
    //var asyncValue = ref.watch(filteredTodosProvider);
    var todos = ref.watch(todosProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoCard(todos[index]);
              })
        ],
      ),
    );
    // return asyncValue.when(
    //   loading: () => const LoadingIndicator(),
    //   data: (todos) {
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(
    //               title,
    //               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           ListView.builder(
    //               shrinkWrap: true,
    //               itemCount: todos.length,
    //               itemBuilder: (context, index) {
    //                 return TodoCard(todos[index]);
    //               })
    //         ],
    //       ),
    //     );
    //   },
    //   error: (err, stack) => Text('Error: $err'),
    // );
  }
}

class TodoCard extends ConsumerWidget {
  final model.Todo todo;

  const TodoCard(this.todo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('#${todo.id}: ${todo.title}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(children: [
                IconButton(
                  onPressed: () {
                    ref.read(todosProvider.notifier).complete(todo);
                  },
                  icon: const Icon(Icons.add_task),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(todosProvider.notifier).delete(todo);
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ]),
            ],
          )),
    );
  }
}
