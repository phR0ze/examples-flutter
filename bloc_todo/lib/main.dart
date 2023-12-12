import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';
import 'bloc/exports.dart';
import 'model/exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TodosBloc>(
            create: (context) => TodosBloc()
              ..add(const LoadTodos(todos: [
                // Adding test data here
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
              ])),
          ),
          BlocProvider<TodosFilterBloc>(
            create: (context) => TodosFilterBloc(
              todosBloc: context.read<TodosBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bloc example',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ));
  }
}
