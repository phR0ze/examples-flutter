import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/model/todo.dart';
import 'providers/todos.dart';
import 'todo_page.dart';
import 'widgets/loading.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          bottom: const TabBar(
            // onTap: (index) {
            //   switch (index) {
            //     case 0:
            //       context
            //           .read<TodosFilterBloc>()
            //           .add(const UpdateTodos(filter: TodosFilter.pending));
            //       break;
            //     case 1:
            //       context
            //           .read<TodosFilterBloc>()
            //           .add(const UpdateTodos(filter: TodosFilter.completed));
            //       break;
            //   }
            // },
            tabs: [
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
    var asyncValue = ref.watch(todosProvider);

    return asyncValue.when(
      loading: () => const LoadingIndicator(),
      data: (todos) {
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
      },
      error: (err, stack) => Text('Error: $err'),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('#${todo.id}: ${todo.title}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Row(children: [
                // IconButton(
                //   onPressed: () {
                //     context.read<TodosBloc>().add(UpdateTodo(todo: todo.copyWith(isCompleted: true)));
                //   },
                //   icon: const Icon(Icons.add_task),
                // ),
                // IconButton(
                //   onPressed: () {
                //     context.read<TodosBloc>().add(DeleteTodo(todo: todo));
                //   },
                //   icon: const Icon(Icons.cancel),
                // ),
              ]),
            ],
          )),
    );
  }
}
