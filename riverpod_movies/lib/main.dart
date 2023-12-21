import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/locator.dart';
import 'ui/home_page.dart';

Future<void> main() async {
  // Initialize the GetIt service locator
  initLocator();

  // Ensure that the WidgetsBinding has been set up before creating the app
  WidgetsFlutterBinding.ensureInitialized();

  // Wrap the app in a Riverpod ProviderScope to make providers accessible to the app
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Demo',
      home: HomePage(),
    );
  }
}
