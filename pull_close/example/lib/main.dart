import 'package:flutter/material.dart';
import 'package:pull_close/pull_close.dart';
import 'const.dart';
import 'image_pager.dart';

void main() => runApp(const MyApp());

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final _imageProviders = List.generate(15, (_) => const AssetImage(Const.assetFreeImage));

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Pull Close Example'),
        ),
        body: Center(
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: _imageProviders.asMap().entries.map((x) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    barrierDismissible: false,
                    builder: (context) {
                      return PullClose(
                        onClosed: () => Navigator.of(context).pop(),
                        child: ImagePager(x.key, _imageProviders),
                      );
                    },
                  );
                },
                child: Stack(
                  children: <Widget>[
                    SizedBox.expand(child: Image(image: x.value, fit: BoxFit.cover)),
                    Positioned(
                      left: 5,
                      bottom: 0,
                      child: Text(x.key.toString(), style: const TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
