import 'dart:io';
import 'package:flutter/material.dart';
import '../model/exports.dart' as model;

class TextView extends StatefulWidget {
  final model.TextEntry entry;
  const TextView(this.entry, {super.key});

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  late Future<String> _data;

  @override
  void initState() {
    super.initState();
    _data = File(widget.entry.path).readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
