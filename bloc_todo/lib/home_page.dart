import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/exports.dart';
import 'model/exports.dart';
import 'todo_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TodosLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
      ),
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
