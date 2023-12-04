import 'package:flutter/material.dart';
import '../widgets/image_scroll_view.dart';
import '../widgets/nav_rail.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image view'),
        backgroundColor: Colors.grey,
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
