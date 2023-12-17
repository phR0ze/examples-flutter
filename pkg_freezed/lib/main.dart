import 'package:flutter/material.dart';

import 'model/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Freezed benefits'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var person = const Person(firstName: 'John', lastName: 'Doe', age: 42);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _text('> General benefits'),
            _text('   Ensures properties are immutable, preventing accidental mutation'),
            _text('   Enforces null safety'),
            _text('> Getters for all properties'),
            _text('   firstName: ${person.firstName}'),
            _text('   lastName: ${person.lastName}'),
            _text('   age: ${person.age}'),
            _text('> Operator overloads'),
            _text('   == equality'),
            _text('> Method helpers'),
            _text('   copyWith(age: 43): ${person.copyWith(age: 43).age}'),
            _text('   toString(): ${person.toString()}'),
            _text('   hashCode: ${person.hashCode}'),
            _text('   toJson(): ${person.toJson()}'),
            _text('   when(): ?'),
            _text('   maybeWhen(): ?'),
            _text('   unions(): ?'),
          ],
        ),
      ),
    );
  }
}

Widget _text(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    ),
  );
}
