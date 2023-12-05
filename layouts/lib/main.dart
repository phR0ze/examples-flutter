import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'const.dart';
import 'screens/narrow/home.dart' as narrow;
import 'screens/wide/home.dart' as wide;
import 'state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppState(),
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "layout examples",
            home: Scaffold(
              body: LayoutBuilder(builder: (context, constraints) {
                return constraints.maxWidth > Const.narrowThreshold
                    ? wide.HomeScreen(constraints)
                    : narrow.HomeScreen(constraints);
              }),
            ),
          );
        });
  }
}
