import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/services.dart';
import 'ui/home_page.dart';

void main() {
  initGlobalServices();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Setup the global snackbar messenger
      scaffoldMessengerKey: locate<GlobalKey<ScaffoldMessengerState>>(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // Setup the app theme
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(
          thickness: MaterialStateProperty.all(10.0),
          thumbColor: MaterialStateProperty.all(Colors.blue),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),

      // Start the app
      home: const HomePage(),
    );
  }
}
