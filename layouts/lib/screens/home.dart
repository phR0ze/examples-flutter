import 'package:flutter/material.dart';
import '../widgets/image_scroll_view.dart';
import '../widgets/nav_rail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<String>> loadImages() async {
    return List.generate(2000, (index) => 'assets/images/placeholder.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Examples'),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder(
            future: loadImages(),
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return constraints.maxWidth > 450
                    ? Row(
                        children: [
                          NavRail(constraints),
                          Expanded(child: ImageScrollView(snapshot.data)),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(child: ImageScrollView(snapshot.data)),
                          NavRail(constraints),
                        ],
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
      }),
    );
  }
}
