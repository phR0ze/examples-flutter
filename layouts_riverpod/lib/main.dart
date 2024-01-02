import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'const.dart';
import 'ui/narrow/images.dart' as narrow;
import 'ui/wide/images.dart' as wide;

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
      home: LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth > Const.narrowThreshold
            ? wide.ImagesPage(constraints)
            : narrow.ImagesPage(constraints);
      }),
    );
  }
}
