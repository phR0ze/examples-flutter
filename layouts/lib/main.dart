import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "layout examples",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Container(
                width: constraints.maxWidth * 0.25,
                height: constraints.maxHeight,
                color: Colors.pink,
                child: const Center(
                  child: Text('Right Sidebar'),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.15,
                    width: constraints.maxWidth * 0.75,
                    color: Colors.blueAccent,
                    child: const Center(
                      child: Text('Header'),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.75,
                    width: constraints.maxWidth * 0.75,
                    color: Colors.amber,
                    child: const Center(
                      child: Text('Main Content'),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.10,
                    width: constraints.maxWidth * 0.75,
                    color: Colors.lightGreen,
                    child: const Center(
                      child: Text('Footer'),
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        // Samll screens
        return Column(
          children: [
            Container(
              height: 100,
              color: Colors.blue,
              child: const Center(
                child: Text('Header'),
              ),
            ),
            Container(
              height: 300,
              color: Colors.amber,
              child: const Center(
                child: Text('Main Content'),
              ),
            ),
            Container(
              height: constraints.maxHeight - 400,
              color: Colors.lightGreen,
              child: const Center(
                child: Text('Footer'),
              ),
            )
          ],
        );
      }),
    );
  }
}
