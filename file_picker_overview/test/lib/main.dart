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

      // Setup the app theme
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),

      // Start the app
      home: const HomePage(),
    );
  }
}
