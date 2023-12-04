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
                          child: Container(color: Colors.green, child: const Content()),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.pink,
                            child: const Content(),
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

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadImages(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return CustomScrollView(slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(2.0),
                sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100.0,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return _buildImage(snapshot.data![index]);
                      },
                      childCount: snapshot.data!.length,
                    )),
              ),
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

// Build image widget
GridTile _buildImage(String image) {
  return GridTile(child: Image.asset(image, fit: BoxFit.cover, cacheWidth: 100));
}

// Simulate loading images
Future<List<String>> _loadImages() async {
  return List.generate(2000, (index) => 'assets/images/placeholder.png');
}
