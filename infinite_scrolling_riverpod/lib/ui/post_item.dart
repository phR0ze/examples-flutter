import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String title;
  final String body;
  final int index;

  const PostItem(this.title, this.body, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '$index: $title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              body,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
