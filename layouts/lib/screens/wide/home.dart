import 'package:flutter/material.dart';
import '../../widgets/image_scroll_view.dart';
import '../../widgets/nav_rail.dart';

class HomeScreen extends StatelessWidget {
  final BoxConstraints constraints;
  const HomeScreen(this.constraints, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Layout Examples'),
          backgroundColor: Colors.blue,
        ),
        body: Row(
          children: [
            NavRail(constraints),
            const Expanded(child: ImageScrollView()),
          ],
        ));
  }
}
