import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/exports.dart';
import 'model/exports.dart';
import 'todo_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BLoC todo example'),
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
                  context
                      .read<TodosFilterBloc>()
                      .add(const UpdateTodos(filter: TodosFilter.pending));
                  break;
                case 1:
                  context
                      .read<TodosFilterBloc>()
                      .add(const UpdateTodos(filter: TodosFilter.completed));
                  break;
              }
            },
            tabs: const [
              Tab(icon: Icon(Icons.pending)),
              Tab(icon: Icon(Icons.add_task)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _todos('Pending Todos'),
            _todos('Completed Todos'),
          ],
        ),
      ),
    );
  }

  BlocConsumer<TodosFilterBloc, TodosFilterState> _todos(String title) {
    return BlocConsumer<TodosFilterBloc, TodosFilterState>(
      listener: (context, state) {
        if (state is TodosFilterLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Number of tasks: ${state.todos.length}'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TodosFilterLoaded) {
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
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return _todoCard(context, state.todos[index]);
                    })
              ],
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}

Card _todoCard(BuildContext context, Todo todo) {
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
                  context.read<TodosBloc>().add(UpdateTodo(todo: todo.copyWith(isCompleted: true)));
                },
                icon: const Icon(Icons.add_task),
              ),
              IconButton(
                onPressed: () {
                  context.read<TodosBloc>().add(DeleteTodo(todo: todo));
                },
                icon: const Icon(Icons.cancel),
              ),
            ]),
          ],
        )),
  );
}
