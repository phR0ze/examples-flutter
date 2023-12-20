import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Now Playing Page'),
      ),
    );
  }
}
