import 'dart:io';
import 'package:flutter/material.dart';
import '../model/exports.dart' as model;

class TextPage extends StatefulWidget {
  final model.TextEntry entry;
  const TextPage(this.entry, {super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  late Future<String> _data;

  @override
  void initState() {
    super.initState();
    _data = File(widget.entry.path).readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.entry.name, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<String>(
            future: _data,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }

              if (snapshot.hasError) {
                return const Text('There is something wrong!');
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
