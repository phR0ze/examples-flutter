import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/common/page_builder.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "layout examples with riverpod",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(28, 40, 55, 1),
        primarySwatch: Colors.blue,
        scrollbarTheme: ScrollbarThemeData(
          thickness: MaterialStateProperty.all(10.0),
          thumbColor: MaterialStateProperty.all(Colors.blue),
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(color: Colors.white, fontSize: 20.0),
          displayMedium: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
      ),
      home: const PageBuilder(),
    );
  }
}
