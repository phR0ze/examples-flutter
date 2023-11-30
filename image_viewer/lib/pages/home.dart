import 'package:flutter/material.dart';
import 'package:image_viewer/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text(Const.appName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_on),
          ),
          IconButton(
            onPressed: () {},
            icon: Transform.scale(
              scale: 1.1,
              child: const Icon(Icons.add_box),
            ),
          ),
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: Const.appName,
                applicationVersion: Const.appVersion,
                applicationIcon: const Icon(Icons.image),
                children: [
                  const Text('This is a simple image viewer app.'),
                ],
              );
            },
            // Push the icon down a bit to make it not look retarded
            // Scale a little to match the grid size
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 1.5),
              child: Transform.scale(
                scale: 1.1,
                child: const Icon(Icons.add_a_photo),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/placeholder.png'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add folder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
