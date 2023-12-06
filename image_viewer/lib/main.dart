import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';
import 'package:provider/provider.dart';
import 'state.dart';
import 'screens/narrow/home.dart' as narrow;
import 'screens/wide/home.dart' as wide;

void main() {
  runApp(const App());
}

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
        home: Scaffold(
          body: LayoutBuilder(builder: (context, constraints) {
            return constraints.maxWidth > Const.narrowThreshold
                ? wide.HomeScreen(constraints)
                : narrow.HomeScreen(constraints);
          }),
        ),
      ),
    );
  }
}
