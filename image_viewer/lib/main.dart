import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/services.dart';
import 'ui/folders_page.dart';

void main() {
  initGlobalServices();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Image Viewer",
      debugShowCheckedModeBanner: false,

      // Configure global snackbar messenger
      scaffoldMessengerKey: locate<GlobalKey<ScaffoldMessengerState>>(),

      // Configure app theme
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        // colorSchemeSeed: Colors.blue,
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.blue,
        //   // accentColor: Colors.blue,
        //   // brightness: Brightness.dark,
        // ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.blue,
        // ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          //primarySwatch: Colors.blue,
          // accentColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scrollbarTheme: ScrollbarThemeData(
          thickness: MaterialStateProperty.all(10.0),
          thumbColor: MaterialStateProperty.all(Colors.blue),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.blue,
        ),
      ),

      home: const FoldersPage(),
    );
  }
}
