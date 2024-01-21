import 'package:dismissible_custom/dismiss_gesture_detector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const assetImageFree = 'assets/images/pixabay-free.jpg';

// Enable mouse draging and scrolling for the page view which is excluded by default.
// https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag
class MouseEnabledScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

void main() {
  runApp(const MyApp());
}

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Custom dimissible'),
      ),

      // Create a new overlay dialog to then experiment with dimissing
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (context) {
              return DismissGestureDetector(
                key: const Key('custom dismissible'),
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    children: <Widget>[
                      // Allows image to take the full screen and be centered
                      SizedBox.expand(child: Image.asset(assetImageFree)),

                      // Draw the close button as back up
                      Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Launch ImageView',
        child: const Icon(Icons.launch),
      ),
    );
  }
}
