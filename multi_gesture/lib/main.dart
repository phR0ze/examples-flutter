import 'package:flutter/material.dart';
import 'multi_gesture.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlingDetails? _fling;
  double _flingVelocity = 700.0;
  double _flingVelocityDelta = 400.0;

  @override
  Widget build(BuildContext context) {
    return MultiGesture(
      velocity: _flingVelocity,
      velocityDelta: _flingVelocityDelta,
      onFling: (fling) {
        setState(() {
          _fling = fling;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Gesture research'),
        ),
        body: Stack(
          children: <Widget>[
            const SizedBox.expand(),
            Positioned(
              left: 20,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: <Widget>[
                      const Text('Fling Velocity: ', style: TextStyle(fontSize: 18)),
                      Text(_flingVelocity.toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _flingVelocity += 10;
                              });
                            },
                            child: const SizedBox(width: 25, height: 25, child: Icon(Icons.add)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _flingVelocity -= 10;
                              });
                            },
                            child: const SizedBox(width: 25, height: 25, child: Icon(Icons.remove)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      const Text('Fling Velocity Delta: '),
                      Text(_flingVelocityDelta.toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _flingVelocityDelta += 10;
                              });
                            },
                            child: const SizedBox(width: 25, height: 25, child: Icon(Icons.add)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipOval(
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _flingVelocityDelta -= 10;
                              });
                            },
                            child: const SizedBox(width: 25, height: 25, child: Icon(Icons.remove)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Result: ${_fling != null ? _fling!.fling.toString() : 'null'}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Velocity: ${_fling != null ? _fling!.velocity.toString() : 'null'}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
