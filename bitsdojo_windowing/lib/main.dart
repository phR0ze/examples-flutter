import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: WindowBorder(
        width: 1,
        color: Const.borderColor,
        child: const Row(
          children: [
            LeftSide(),
            RightSide(),
          ],
        ),
      )),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: Const.backgroundEndColor,
        child: Column(
          children: [
            // Add draggable here to match main content side
            WindowTitleBarBox(
              child: MoveWindow(),
            ),
          ],
        ),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  const RightSide({super.key}) /*  */;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Const.backgroundStartColor, Const.backgroundEndColor],
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                // MoveWindow is a widget that moves the window when you drag it
                Expanded(child: MoveWindow()),
                const WindowButtons(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(),
      ],
    );
  }
}

var buttonColors = WindowButtonColors(
    iconNormal: Const.iconNormalColor,
    mouseOver: Const.mouseOverColor,
    mouseDown: Const.mouseDownColor,
    iconMouseOver: Const.iconMouseOverColor,
    iconMouseDown: Const.iconMouseDownColor);
