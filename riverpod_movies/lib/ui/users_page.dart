import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Users Page'),
      ),
    );
  }
}
