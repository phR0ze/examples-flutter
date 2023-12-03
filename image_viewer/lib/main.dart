import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'package:image_viewer/pages/home.dart';
import 'package:provider/provider.dart';
import 'components/state.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: Const.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

void main() {
  runApp(const App());
}
