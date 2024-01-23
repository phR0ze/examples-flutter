import 'package:flutter/material.dart';

class ImplicitContainer extends StatefulWidget {
  const ImplicitContainer({super.key});

  @override
  State<ImplicitContainer> createState() => _ImplicitContainerState();
}

class _ImplicitContainerState extends State<ImplicitContainer> with SingleTickerProviderStateMixin {
  bool _bigger = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: Center(
          child: AnimatedContainer(
            color: Colors.blue,
            width: _bigger ? 400 : 10,
            height: _bigger ? 400 : 10,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            onEnd: () {
              setState(() {
                _bigger = !_bigger;
              });
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _bigger = !_bigger;
            });
          },
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
