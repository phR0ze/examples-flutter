import 'package:flutter/material.dart';
import '../widgets/image_scroll_view.dart';
import '../widgets/nav_rail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Examples'),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth > 450
            ? Row(
                children: [
                  NavRail(constraints),
                  const Expanded(child: ImageScrollView()),
                ],
              )
            : Column(
                children: [
                  const Expanded(child: ImageScrollView()),
                  NavRail(constraints),
                ],
              );
      }),
    );
  }
}
