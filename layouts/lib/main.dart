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
        return Column(
          children: [
            Container(
              height: 50.0,
              color: Colors.blue,
              child: const Center(
                child: Text('App Bar'),
              ),
            ),
            Expanded(
              child: constraints.maxWidth > 600
                  ? Row(
                      children: [
                        Container(
                          width: 200.0,
                          color: Colors.amber,
                          child: const Center(
                            child: Text('Navigation Rail'),
                          ),
                        ),
                        Expanded(
                          child: Container(color: Colors.green, child: _buildContent()),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.green,
                            child: _buildContent(),
                          ),
                        ),
                        Container(
                          height: 60.0,
                          color: Colors.amber,
                          child: const Center(
                            child: Text('Bottom Navigation'),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      }),
    );
  }
}

GridView _buildContent() {
  return GridView.count(
    crossAxisCount: 3,
    mainAxisSpacing: 2.0,
    crossAxisSpacing: 2.0,
    children: List.generate(100, (index) {
      return _buildImage();
    }),
  );
}

GridTile _buildImage() {
  return GridTile(
      child: Image.asset(
    'assets/images/placeholder.png',
    fit: BoxFit.cover,
    cacheWidth: 100,
  ));
}
