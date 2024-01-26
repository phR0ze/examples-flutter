import 'package:flutter/material.dart';
import 'package:pull_close/pull_close.dart';
import 'const.dart';
import 'image_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Pull Close Example'),
        ),
        body: Center(
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: List.generate(15, (index) {
              return ImageView(
                index: index,
                image: Const.assetFreeImage,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    barrierDismissible: false,
                    builder: (context) {
                      return PullClose(
                        onClosed: () => Navigator.of(context).pop(),
                        child: ImageView(
                          index: index,
                          image: Const.assetFreeImage,
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
